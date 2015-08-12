From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/16] diff: use tempfile module
Date: Wed, 12 Aug 2015 09:41:49 -0700
Message-ID: <xmqqy4hglar6.fsf@gitster.dls.corp.google.com>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
	<404c8bc508639a5723420691d9daa122f10d7cd4.1439198011.git.mhagger@alum.mit.edu>
	<xmqqbnedr3sp.fsf@gitster.dls.corp.google.com>
	<55CB62B7.8060706@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 12 18:41:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPZ6C-000638-W3
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 18:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934399AbbHLQlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 12:41:53 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36204 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934223AbbHLQlv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 12:41:51 -0400
Received: by pdco4 with SMTP id o4so9179536pdc.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 09:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wuOBC6KHUBB2sNx62Tt/mlYKT3D5KCyXG2yCNt9eTAs=;
        b=b4yW9oa5lZ1Fyhhn+QmZH8o+sHaIHwoWyQihp4pQx0I0LfjQzPA2ulFJiGbAXIM3LD
         pOE0QbBMOGaBA458Ev1cKKMUJ/rqDKHuGI5ynRray/fYQipsBIri/GS6Z66reHkRGvIq
         3aYZhS9Bolhd4k3kwpV4hp2jYj+zV1C8aIYS0KBc2rFng6ieuh+z4lQDECApD7qPV4nd
         Xpci9hxNF7To43Hl4iTK3wvQ92NZS3qLqQDYBl3f7Bdf/ndgrcMWZx7bOSZADOSazzUJ
         TuIvmS2e41pmUIS9lp6vsWoPcEN5hbUc5MGKhW6RfluLDWYev/PbSrORFO3enokBGqU0
         tugQ==
X-Received: by 10.70.140.139 with SMTP id rg11mr29055280pdb.34.1439397711265;
        Wed, 12 Aug 2015 09:41:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id gx1sm7020313pbc.29.2015.08.12.09.41.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 09:41:50 -0700 (PDT)
In-Reply-To: <55CB62B7.8060706@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 12 Aug 2015 17:13:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275782>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> No, prepare_temp_file() sometimes sets diff_tempfile::name to
> "/dev/null", and sometimes to point at its argument `name`.

That explains everything.  Thanks.  It's been a while since I wrote
this part of the system ;-).
