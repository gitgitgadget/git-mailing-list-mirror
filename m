From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH] zsh completion: 5.0.3 compat, use emulate
Date: Wed, 30 Apr 2014 05:00:48 -0500
Message-ID: <5360c9d095f5c_47db12fd310ef@nysa.notmuch>
References: <EMXW5CZ-001FUQ-3S@ilmenite.field.spodhuis.org>
 <53609249b388d_597a125b3084d@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Phil Pennock <pdp@spodhuis.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 12:11:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfRUA-0003L2-3Q
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 12:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174AbaD3KLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 06:11:25 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:33007 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbaD3KLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 06:11:25 -0400
Received: by mail-yh0-f43.google.com with SMTP id f10so1388444yha.16
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 03:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=1xNm/keaB/iODAMQBuU0qBVRe6KOA+UYxgE1moNQ26Y=;
        b=uhR4kGse8kbfJA03lnkDASbRMVcwhj/782FX8Ew9SjTyqzpKKH1gLF5Tm84ksd+27/
         G2Uhpciwv2QzUx1obmIiAemhfCvfFAoXJLadp63gquvRxABYw8dw4Dhp1Mjeneyz1Ybb
         TuNtA99s6c/CiCbueqOpK09Ps3/sHNQQNtVGCEAoeDJagU5ppn2edNmAZUw3JoZLK2PK
         einZfmcbXdKIKEe5hw6ElRKyVacaOrP4XlQrTgtWTOWWIDehSZSdxYRztC4gVHlPdtaB
         8H05mbfvGUR7+W2wBOB3lGmW/8yi9hljtIwMkSKKfPo+qkj6x/Yt/0OknboP6c9cc5Ce
         XvLw==
X-Received: by 10.236.20.68 with SMTP id o44mr4463482yho.76.1398852684349;
        Wed, 30 Apr 2014 03:11:24 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f2sm42022640yhg.7.2014.04.30.03.11.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 03:11:23 -0700 (PDT)
In-Reply-To: <53609249b388d_597a125b3084d@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247696>

Felipe Contreras wrote:
> Phil Pennock wrote:
> > The bash completion pulled into zsh was being pulled in _as_ zsh, but
> > used patterns which relied on falling through as unhandled.  In zsh
> > 5.0.3 this no longer works, resulting in:
> > 
> >     __git_complete_remote_or_refspec:33: bad pattern: +*
> > 
> > Fix by telling zsh to emulate sh while sourcing the bash config file,
> > which stickily preserves compatibility options in the function context.
> > This usage of "emulate" came in with zsh 4.3.10, released 2009-06-01.
> 
> I'm using 5.9.5 and I don't see any issue. Howe exactly have you
> configured this script?

I meant 5.0.5.

Anyway, I've tried with multiple versions of zsh and I'm able to
reproduce the issue by doing 'git push origin <tab>'. However, it seems
the issue was instroduced in 5.0.3, and fixed in 5.0.4, so I don't think
we should do anything on our side.

-- 
Felipe Contreras
