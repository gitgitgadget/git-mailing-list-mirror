From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 19:37:06 +0200
Message-ID: <CAB9Jk9Aa4d4H5q1euCJ4hdc_K9iBrfiJFnyAYQ+BRNX3D023gg@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<m2fw5vooem.fsf@linux-m68k.org>
	<CAB9Jk9Dqoom-hBQPG5iqe2JyiJtVoFWZ9-5W9ktUsa9F9mbXRQ@mail.gmail.com>
	<m2r4pf1xh6.fsf@igel.home>
	<CAB9Jk9Bqq=fs4v-oAj_TiaSw5WOiQQFsm_WEZP_ECyPW1L_DHg@mail.gmail.com>
	<m2fw5va4jc.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 19:38:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJSss-0008Dn-K0
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 19:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527Ab2JCRhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 13:37:08 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:51743 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab2JCRhH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 13:37:07 -0400
Received: by vbbff1 with SMTP id ff1so8147140vbb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 10:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XBvr7DPIV2vyTjQeABl2kM2yDRtgJlhM9z8vY8uw2m0=;
        b=gkdNU5mQv3NrLFJqxaP5k1mtMSqvMSAKx0p1Pt+KFKhVce+n5YxMP31LffN8anGNUX
         O6N4xrDIkUSNmAcGA6895wYxuczBCWQSjN6lgJJCyYXQXdPs3az2fGxPCnFEp7VQuOmZ
         XzwUb8t4bCbL/XlDNn4yboiQ+cYLSl3WkSadM7OUgK2zuXCglKp+/SPWf9aDcEOGa9YX
         jk2e9w4yohCeqtolq5ykL+9jNU2ktvB7XKel0jceO1LPHMSylP1xMlBA6Q3Zr2624TTn
         p97LBBDMB05qcroUkz8X4xNnZjU6ZPuGAnj0I3vPy6llQUFpbqeCw8XIoM+AEu/bpnlx
         1CRA==
Received: by 10.52.36.76 with SMTP id o12mr1266252vdj.40.1349285826077; Wed,
 03 Oct 2012 10:37:06 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 3 Oct 2012 10:37:06 -0700 (PDT)
In-Reply-To: <m2fw5va4jc.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206915>

Hi Andreas,

> But the commit object _is_ created, it just doesn't have a unique name.

The command may internally create the commit object, compute its sha and then
seeing that there is already one in the repo with the same sha, throw it away.
But this is an implementation detail. The net result for the user is
that after the
command there are no new objects.

-Angelo
