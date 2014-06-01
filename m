From: Atsushi Nakagawa <atnak@chejz.com>
Subject: Re: Reset by checkout?
Date: Sun, 01 Jun 2014 13:58:55 +0900
Message-ID: <20140601135853.8223.B013761@chejz.com>
References: <5389b57138645_68b153b2f8a5@nysa.notmuch> <538a682c9540f_140996b2fc71@nysa.notmuch>
Reply-To: Atsushi Nakagawa <atnak@chejz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 07:18:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wqy9z-0002PG-O9
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 07:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbaFAE66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 00:58:58 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52062 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbaFAE65 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 00:58:57 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so795756pad.19
        for <git@vger.kernel.org>; Sat, 31 May 2014 21:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chejz.com; s=google;
        h=date:from:to:subject:cc:reply-to:in-reply-to:references:message-id
         :mime-version:content-type:content-transfer-encoding;
        bh=Mhh3sqRDaNUXS5bQYndLv4Hca/yR7gujnOnYz/B3j5Y=;
        b=mefyDpO2dKSp1vbsTGZZkokSCUCrZd6/clvIMUJWbcVcTUPW8pK5762W0UVuiPRzgo
         nAvs13krENDU9Y+Sgp9vHoYPFP688o9Mkd+p1jCErK8n82gm/aXxRrVMDrwuhHf5s+yY
         hF9n4gjMO95dDvAzdDoA0CYuU3DFyTdhzGLRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:cc:reply-to:in-reply-to
         :references:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Mhh3sqRDaNUXS5bQYndLv4Hca/yR7gujnOnYz/B3j5Y=;
        b=ZGYsva67TPeswp+YweYaTe9FqlFfZfz/Kv6kNma4rmOUJXwh8SYoTZLgP0fJ2vpPQa
         33EMIO4070ZAmrDhnaZ9KAys0sQhBDHua2FcjBC7JxNPftz+UPQMXg3xB0qCYynuyNUu
         KhtpJZe61Z+xsHCykbk36pW3OI9wNdH8pg36CqjTEu2g3U2S7h9F8MCMU9I1JwgrM51G
         eG6B52fz7CiPewJzqJtVvsrR0vS7zwy1fy+V01WrnuVdTjwE7StFvRGeMLzPaiBCJyDJ
         ZB6Je7IjBHi0GZRCw0J/c6pEieZ57vhnWOPXUAS3wWTcfu4xCD4p/Sy5uftzr0c3hMs/
         AicA==
X-Gm-Message-State: ALoCoQliN9N6xpMOAfsg9r70zAy+Yx7369EyucyrqU8UqpO2nZfQ2y03cgmp1zhOGMfFUSeIgmQH
X-Received: by 10.68.189.68 with SMTP id gg4mr31235152pbc.42.1401598736710;
        Sat, 31 May 2014 21:58:56 -0700 (PDT)
Received: from [127.0.0.1] (KD106168138162.ppp-bb.dion.ne.jp. [106.168.138.162])
        by mx.google.com with ESMTPSA id aj10sm43317966pac.43.2014.05.31.21.58.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 31 May 2014 21:58:56 -0700 (PDT)
In-Reply-To: <538a682c9540f_140996b2fc71@nysa.notmuch>
X-Mailer: Becky! ver. 2.65.07 [en]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250519>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> Felipe Contreras wrote:
> > Atsushi Nakagawa wrote:
> > > Ok, the typical use case is: I'm on 'master' and I make a few test
> > > commits.  Afterwards, I want to discard the commits and move back to
> > > 'origin/master'.  I could type 'reset --hard origin/master' and risk
> > > blowing away dirty files if I'm not careful.  Or, I could use "reset by
> > > checkout" and be carefree.
> > 
> > Doesn't 'git reset orign/master' do that?
> 
> Unless you want to keep the staged files, in which case adding the
> --stage and --work options I originally suggested[1] would help.
> ...
> 
> [1] http://article.gmane.org/gmane.comp.version-control.git/247086

What I was looking for is basically what 'git checkout' does to the
working tree when it moves from one commit to another, as well as the
semantic checks it offers such that I'm incapable of making an
unrecoverable change (i.e. It aborts if I'm about to blow away changes
that aren't committed.).

I was introduced to 'git reset --keep' in another reply and that for
most intent and purpose is what I think I was after.

Cheers,


-- 
Atsushi Nakagawa
<atnak@chejz.com>
Changes are made when there is inconvenience.
