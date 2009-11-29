From: Uri Okrent <uokrent@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Sun, 29 Nov 2009 11:50:50 -0800
Message-ID: <4B12D09A.3080408@gmail.com>
References: <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com> <20091125222037.GA2861@coredump.intra.peff.net> <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com> <20091127062013.GA20844@coredump.intra.peff.net> <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302> <20091127095914.GA4865@sigill.intra.peff.net> <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302> <6839293b0911270827x54947c64q5f93e37664bc20f3@mail.gmail.com> <7vk4xbn7nl.fsf@alter.siamese.dyndns.org> <4B101ED1.9000607@gmail.com> <20091127205305.GB26921@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	James Pickens <jepicken@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 29 20:51:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEpnU-000813-PT
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 20:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbZK2Tux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 14:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbZK2Tuw
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 14:50:52 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:51098 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZK2Tuw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 14:50:52 -0500
Received: by pzk1 with SMTP id 1so2045002pzk.33
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 11:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=im1b2NCSr0NJ7Tg75RjCRXx3Uofz8cyY2HxT7IvRMRc=;
        b=fzQts2/w9WqX2ui6iMGbVLqsyfEPdSOtj/yzEWn3tzV0k19x830KWTtD2hoptsm+A+
         pW8caDKcw7lxBgpxQbQjQGC2QAtKZR+5SJ49KVXjmIfE29wnyQx7sB/+4iS7+NlS5RQZ
         Hcviyk4J3HmhiHzTdbGoJdSj01OFiNCZObxvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=edeJ+HE1PynXwi/61Mm5srFfDVAr14Ai7u+f6V+R/6zK82bsWte5iOymUgpaqOFPF2
         bHRkeAA2b+cPdL7+neDd+NGJSNApmjOXQk2Mbta2daqFRLhT1M9XrzWrITgwzejn+7DD
         dOMD72McaAKagrKPnHBoGzH/R6VvncWX4yNUI=
Received: by 10.114.214.17 with SMTP id m17mr5370801wag.197.1259524258274;
        Sun, 29 Nov 2009 11:50:58 -0800 (PST)
Received: from ?192.168.0.8? (cpe-76-90-12-237.socal.res.rr.com [76.90.12.237])
        by mx.google.com with ESMTPS id 22sm2462419pzk.6.2009.11.29.11.50.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 11:50:57 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091127205305.GB26921@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134036>

Jeff King wrote:
> On Fri, Nov 27, 2009 at 10:47:45AM -0800, Uri Okrent wrote:
>> As a matter of
>> fact, my personal opinion (which I probably neglected to mention) is
>> that grep default behavior should stay the same since it is semantically
>> closer to unix (or gnu) grep.
> 
> Keeping consistency with non-git grep has been mentioned a few times in
> this thread.  I really don't understand how default file selection is
> supposed to maintain consistency with non-git grep. Regular grep
> defaults to stdin if no paths are given. That mode doesn't make any
> sense for git grep.
> 
> So of the two options (grepping the list of files from the full tree, or
> the list of files rooted at the current directory), how is one closer to
> non-git grep than the other?
> 
> -Peff

I guess you're right, in that neither is exactly the same as non-git,
and so it's impossible to objectively quantify how one is "closer". My
general feeling though is that grep rooted at the current directory is
more similar because grep -r does exist and is common enough that the
layman isn't too surprised at git's default behavior. Git grep with
--full-tree though, has no analogue in non-git grep.

-- 
    Uri

Please consider the environment before printing this message.
http://www.panda.org/how_you_can_help/
