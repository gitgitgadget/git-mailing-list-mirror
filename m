From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: checkout won't checkout?
Date: Thu, 18 Jun 2015 15:32:03 -0700
Message-ID: <xmqqzj3wbqcc.fsf@gitster.dls.corp.google.com>
References: <CAE5ih7-=WPme_BxgAjtm9hrShxTk1z+uDM-LXzc3BcN3n2vqAg@mail.gmail.com>
	<xmqq4mm4d53f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 00:32:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5iM0-0008Ut-1Y
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 00:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbbFRWcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 18:32:07 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37326 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbbFRWcF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 18:32:05 -0400
Received: by igblr2 with SMTP id lr2so1973846igb.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xdojtKLHl/jJynBWVeOFaYamuD87uCgOrz48sF7d60E=;
        b=eRqRatx56Et06+85XBR9qypLwnCKYFvpZNqQT8SNkXi/kpMsgE3XyuuOlbDHpNL2L1
         KvlvO6oFF5/cUlk1FbTLAzmX8JcQ2Wsrsm8T36c1Jo7Rbv5E0K4ltJo6KTSSqIKNZU39
         kAlIhYjstSOBm4SksWB0gTaiIKJF1oCi6tn+2JV1aIVLfNKhHg7vB2EO5dbzqyhEm92z
         80n0agPzTM9hlj5bwnNf8BLVlUhZV2Tt0TUIpsw/WhPt/MBNA+WVDm6NAgak/PpBqZiO
         N68BK9yK5s8iXO5DR3k7a8X+tz/1CutsvFa3eOATbTt4lbh7GaiAP275mIuNC4oXPl1Y
         kfLQ==
X-Received: by 10.50.90.179 with SMTP id bx19mr407268igb.43.1434666724966;
        Thu, 18 Jun 2015 15:32:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id f82sm5821822ioj.37.2015.06.18.15.32.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 15:32:04 -0700 (PDT)
In-Reply-To: <xmqq4mm4d53f.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 18 Jun 2015 15:28:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272089>

Junio C Hamano <gitster@pobox.com> writes:

>> $ git checkout upstream/master -- subtree
>> $ git diff upstream/master -- subtree
>> -- still lots of deltas
>
> Does this show _ONLY_ additions?  Or does it include modifications
> and removals?

The reason I ask this question is because of 

http://thread.gmane.org/gmane.comp.version-control.git/234903/focus=234924
