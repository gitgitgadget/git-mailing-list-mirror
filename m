From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: getbundle changed in mercurial 3.0
Date: Tue, 13 May 2014 15:59:55 -0500
Message-ID: <537287cba3013_76dad6b2f8dd@nysa.notmuch>
References: <1400008359-18267-1-git-send-email-1007380@gmail.com>
 <xmqqzjilmnad.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	William Giokas <1007380@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 23:10:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJyT-0003RC-RQ
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbaEMVKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:10:54 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:37286 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbaEMVKx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:10:53 -0400
Received: by mail-ob0-f169.google.com with SMTP id vb8so1103619obc.14
        for <git@vger.kernel.org>; Tue, 13 May 2014 14:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=+uJU35TNz7AB710cmVFya9slh6C13RtRt2i7cRliAu8=;
        b=CY/NSxLveijP2DVwZC3oK3pUKiU0czRQCHsJbQo4Rbx8grZ/oKEoInUsG7w2ymwBlA
         LPsi1BzBUTt5BOCj6or1lmkj9yZ7Z9R1xuN8G/di7/htjC9RMI99/cDXyYHBMPmSBCbV
         e5J9PSQPHaISdbAXsuflP+pKhVhtv9U5yG0gBIaJ6YpLJr74BaC5yhX+XAsv2rTQmSDM
         /sAubjOpYLtpVnSVTPLdyeKhXcd7kaTaOSBRQqFth/dOjW1qzdfdNX8tHZ29PJ1GLe1c
         TljUKEX2SVDhKIvzgYsiWe2HXZCwIO+J7Y1dGYfVujVTjK+OF0QGBUZzUIAofN9TALJj
         bkTA==
X-Received: by 10.60.73.39 with SMTP id i7mr45038955oev.51.1400015452708;
        Tue, 13 May 2014 14:10:52 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ko3sm63430618oeb.1.2014.05.13.14.10.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 14:10:52 -0700 (PDT)
In-Reply-To: <xmqqzjilmnad.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248855>

Junio C Hamano wrote:

> The way I envision the longer term shape of git-remote-hg.py in the
> contrib/ is either one of these two:
> 
>  (1) manage it just like contrib/hooks/multimail/, keeping a
>      reasonably fresh and known-to-be-good snapshot, while making it
>      clear that my tree is not the authoritative copy people should
>      work off of;
> 
>  (2) treat it just like contrib/emacs/vc-git.el, which found a
>      better home and left my tree at 78513869 (emacs: Remove the no
>      longer maintained vc-git package., 2009-02-07); or
> 
> The first one may be more preferrable between the two, if only because
> distros would need time to adjust where they pick up the source
> material to package up, but it still needs cooperation with the
> "authoritative upstream" and this project to allow us to at least
> learn when the good time to import such good snapshots.

I will not do that.

If you want my help to improve *your* tree, you have to start by
answering the *one* question I've repeatedly asked you to clarify.

In fact if you go for this I would consider it an act of sabotage
against these new projects.

If you hadn't made me waste all this time chasing a non-attainable goal,
these projects would already be packaged by distributions, instead of
hidden in some corner of /usr/share.

Distributions wouldn't even be aware of the move, and it might take bug
reports to make them realize that. There will be already enough damage
to the reputation of these tools with Git v2.0 shipping them broken.

Not aligned at all with your previous statement that you wanted these to
"flourisn".

In fact, I think you should remove them already from v2.0. Because this
doesn't need release candidates. Unless you think user feedback will
make you change your mind about not graduating them, moving them in 2.0,
or 2.1 will be the same, since you are going to ignore the feedback
anyway.

This also has the advantage that you won't be shipping them broken in
v2.0.

At the very least there should be a big fat message warning each time
the tools are run, warning the users that they are unmaintained, and the
right location for them. And yes, I also think this should be done for
v2.0.

-- 
Felipe Contreras
