From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH RFC v2 02/19] rebase -i: reword complains about empty
 commit despite --keep-empty
Date: Wed, 09 Jul 2014 20:02:40 +0200
Message-ID: <53BD83C0.20607@gmail.com>
References: <53A258D2.7080806@gmail.com>	<cover.1404323078.git.bafain@gmail.com>	<b7ee74ddb785f0e087b30ca6be11723ca199fa03.1404323078.git.bafain@gmail.com> <xmqqpphf8u3x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 20:02:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4wCe-0007IW-AD
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 20:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbaGISCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 14:02:44 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:57680 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756016AbaGISCo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 14:02:44 -0400
Received: by mail-we0-f173.google.com with SMTP id t60so7887390wes.32
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BLrB98oDLvx6r1d8phnyojgAqp+6Mtj7hFpX4V19ASI=;
        b=lkJrkzhW86yYOvSqwzARIQmU/DVIYYXco43j22RAbPZ0/mvI5yy7aJe54CiYyio8rf
         /FZe2G4mPReeGA7D0y80sguF4yeYrTTLOhpmbtYDGWmxbDcjMgdr4R01DqoaXRKOfk7Z
         S2SNS5cCxTBFC1ZientbrZj3I2DDTAzulXGeT7Wgc9LYtzy5Xt9sekcahr2HPAVNFnut
         OWqqzJ9wGI9XgkUWVf+cG1B2wRZ4X+ggdDYVSKM7vVd5uC4B2bgMPZFMOmv3PUwk4+JD
         WV87ZLMpnGtVqV2/jHxVcRQNLV9GaVqwLmAOUkHpJ+VZAEuLeQXoMZJUwcxxifIdwp8+
         gNeA==
X-Received: by 10.194.123.105 with SMTP id lz9mr6125468wjb.122.1404928962611;
        Wed, 09 Jul 2014 11:02:42 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id n2sm17704980wix.15.2014.07.09.11.02.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Jul 2014 11:02:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqpphf8u3x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253137>

Junio C Hamano writes:
> Fabian Ruch <bafain@gmail.com> writes:
>> Subject: rebase -i: reword complains about empty commit despite --keep-empty
> 
> I had to read the title and then the log twice before understanding
> that the above is not "change the complaint message" (i.e. "reword
> complaints" spelled incorrectly) but is a description of the current
> behaviour (i.e. "the command complains when 'reword' is used on an
> empty commit") that is not accompanied by an evaluation ("ok, it
> complains; are you saying it is a good thing or a bad thing?") or an
> action ("if it is a bad thing, what are you doing about it?").
> 
> Perhaps
> 
> 	rebase -i: allow rewording an empty commit
> 
> or something?

I thought "...despite --keep-empty" would already imply that "reword
complains about empty commit" is not supposed to happen, the action
would have been obvious. However, I understand that --keep-empty is
first of all concerned with which commits of $upstream...$orig_head end
up on the initial to-do list and the git-rebase manual page doesn't
mention that it picks commits using the --allow-empty option. It is
simply a necessity of a script not to complain about something it put on
the to-do list itself.

The subject reads now

    rebase -i: allow rewording an empty commit without complaints

trying to convey that this is not a new feature but a bug fix.

   Fabian
