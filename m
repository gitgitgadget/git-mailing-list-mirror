From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [BUG] git-log shows first parent and repeated last for octopus
 merge
Date: Wed, 18 Oct 2006 09:35:32 -0700
Message-ID: <453657D4.70502@gmail.com>
References: <eh5242$rar$1@sea.gmane.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 18:36:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaEOr-00079S-9h
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 18:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbWJRQfj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 12:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161205AbWJRQfi
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 12:35:38 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:28049 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161115AbWJRQfh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 12:35:37 -0400
Received: by nz-out-0102.google.com with SMTP id z3so120371nzf
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 09:35:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=NOVJ9V/Lc7SA9kPp76ub1AEqKjespvpLdvwW6YLr6A+gyxzV0LO7hNEgrow6iqKpQKnwCzPZNHdmz1o3M4wm6hhW06Q3V+WmeWsN65JwTwdqb70J8DAkYt6+lDiMoTXD7PWfGlTOIeeGqP1HWYJ2mTg12eMJgBgSJL0cL+UwOXY=
Received: by 10.64.156.12 with SMTP id d12mr14804258qbe;
        Wed, 18 Oct 2006 09:35:35 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.233.231.217])
        by mx.google.com with ESMTP id p4sm1436495qba.2006.10.18.09.35.34;
        Wed, 18 Oct 2006 09:35:35 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eh5242$rar$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29246>

Jakub Narebski wrote:
> When trying to find how many merges and how many octopus merges (merges with
> more than two parents) are in git.git repository I have encountered the
> following strange output of git-log:

Maybe the following will find what you're looking for:

git-rev-list master --parents \
	|sed -e 's/[0-9a-f]\{40\}//' -e 's/ [0-9a-f]\{40\}/*/g' \
	|sort \
	|uniq -c
