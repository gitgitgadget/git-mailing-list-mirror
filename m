From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 1/2] t5520-pull: Add testcases showing spurious
 conflicts from git pull --rebase
Date: Sun, 8 Aug 2010 16:43:58 -0500
Message-ID: <20100808214358.GB6962@burratino>
References: <1281294286-27709-1-git-send-email-newren@gmail.com>
 <1281294286-27709-2-git-send-email-newren@gmail.com>
 <201008082336.18270.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, santi@agolina.net, Johannes.Schindelin@gmx.de
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Aug 08 23:45:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiDgX-00088x-BT
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 23:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772Ab0HHVpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 17:45:23 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49335 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266Ab0HHVpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 17:45:22 -0400
Received: by yxg6 with SMTP id 6so3249321yxg.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 14:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Q1CG9rQ5PSgyTNR8N9hT1AEpeZnu2LrNgsI9XMdF8xo=;
        b=p7hdFy1rSH/C1c1LQGuos3ZLPR7Gv1J4UyHpquzG6lDxjMrrKQ5V3BpDNWVBJw4dsY
         JX9hrcKgbINTMUhLj1X7ltd6TFddyEPKCiUH4ObvmJIKu+xdwooYBGCy8ltwO/AQNrDZ
         N3frliTRnCungawfRncg2A9I4SJutTbqaeth0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Hw5404jg4QwniRMIWQCLt5lMYj9hULJ7Opgh6eUAiG0G75LRorwO4vln4XdbHpycr6
         YQ9oNdVt1/C2PvjzyMHmRo5Tpg3xLHFso5YEGoWq13v73sKlp1vvbKND0hlfG3zbv0mn
         caUQU8QsZDtIxxYTBkb6mzELb0Z75WuZgqa6A=
Received: by 10.101.131.17 with SMTP id i17mr6520358ann.229.1281303921887;
        Sun, 08 Aug 2010 14:45:21 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id i30sm7083977anh.29.2010.08.08.14.45.20
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 14:45:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008082336.18270.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152933>

Johannes Sixt wrote:
> On Sonntag, 8. August 2010, Elijah Newren wrote:

>> +test_expect_success 'setup for avoiding reapplying old patches' '
>> +	(cd dst &&
>> +	 (git rebase --abort || true) &&
>
> Perhaps:
>
> 	test_might_fail git rebase --abort &&
>
> but I'm not sure whether that's the intended use of test_might_fail.

It is.  Thanks for noticing.
