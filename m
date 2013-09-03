From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] Document pack v4 format
Date: Tue, 3 Sep 2013 18:49:02 +0700
Message-ID: <CACsJy8CZP+55nhfEbgRGa9=y0PyExyHt_seiSc23kB31-_c1Hg@mail.gmail.com>
References: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
 <1377917393-28460-1-git-send-email-pclouds@gmail.com> <alpine.LFD.2.03.1309030156410.14472@syhkavp.arg>
 <alpine.LFD.2.03.1309030231350.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 03 13:49:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGp72-0003ph-Pk
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 13:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799Ab3ICLtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 07:49:33 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:34931 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932597Ab3ICLtc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 07:49:32 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so6402008oah.20
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 04:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cGOaAyGhPh21t0foU4IKMYhV1cVjwg20D1fEq9Syw9A=;
        b=JYwzcyPlO2gskVgyKasibvxg7ugxxAO8PPacW9mEvVwvVYFSC/zZVsmuJQaXsK2lUE
         6wOIjgCJf4cYwXu7ZMnUZl9+OwnFV51l9QPM16f8/SxW9o/NxLqrYU+wpelO35eHmq5g
         vz1mxxiVjutnaJZ4mL5QP1YjOcJjc0gYHywRK6Iv4HnxTUz0p+vA5c0DGxmpdEuuErR5
         JiNlY6OFcOU5Z4Qv44jFdZ/qruvc+lHcO4RopgFHwh9AIOSCjTfrigO8xTbtzCXW7kYg
         xOz+kG6qvVMNVOg4fycguKI2XLwBnxW+z0R1i6EMh6ymEizoIhHkVvM0aLqJWK6tMeKj
         9P1Q==
X-Received: by 10.182.214.98 with SMTP id nz2mr20637276obc.37.1378208972115;
 Tue, 03 Sep 2013 04:49:32 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 3 Sep 2013 04:49:02 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309030231350.14472@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233717>

On Tue, Sep 3, 2013 at 1:46 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> So... looks like pack v4 is now "functional".
>
> However something is still wrong as it operates about 6 times slower
> than pack v3.
>
> Anyone wishes to investigate?

You recurse in decode_entries too deep.I check the first 10000
decode_entries() calls in pv4_get_tree(). The deepest level is 3491.
-- 
Duy
