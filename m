From: Pascal Obry <pascal@obry.net>
Subject: Re: Question about git rebase --onto
Date: Wed, 17 Feb 2010 10:25:24 +0100
Organization: Home - http://www.obry.net
Message-ID: <4B7BB604.20205@obry.net>
References: <4B6865A9.60603@obry.net> <7v636f7biw.fsf@alter.siamese.dyndns.org> <4B686CAC.7020103@obry.net> <7vhbpx3it2.fsf@alter.siamese.dyndns.org> <4B6AF9EE.3000205@obry.net> <7vr5p1gd2t.fsf@alter.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 10:25:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhg9w-000520-UY
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 10:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732Ab0BQJZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 04:25:21 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40422 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101Ab0BQJZT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 04:25:19 -0500
Received: by vws8 with SMTP id 8so622722vws.19
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 01:25:17 -0800 (PST)
Received: by 10.220.107.21 with SMTP id z21mr5413597vco.197.1266398717408;
        Wed, 17 Feb 2010 01:25:17 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-68-29.w83-204.abo.wanadoo.fr [83.204.186.29])
        by mx.google.com with ESMTPS id 31sm4060305vws.20.2010.02.17.01.25.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Feb 2010 01:25:15 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <7vr5p1gd2t.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140223>

Junio,

> Thanks for spending time to reproduce---and please do report (and preserve
> the reproducible state if possible) when you see a breakage (like this
> one, or some other form) next time.

I have a reproducer this time.

$ git --version
git version 1.7.0.14.g7e948

$ git clone http://git.sv.gnu.org/r/v2p.git
$ cd v2p/

$ git branch v3.1 origin/v3.1

$ git co -b po/new-context-support origin/po/new-context-support

$ git cherry -v master po/new-context-support
+ bb8647179385ecf2a5053da9a4af9e24437a5b34 Modifications to use the new
AWS's context implementation.
+ 12db018f5a448869b1679550cb2fd0e33336a6c9 Minor reformatting.
+ f7888edb7572ca6d62f35e594d231c7974bc9515 Fix testsuite to pass with
the new context support.

$ git rebase --onto v3.1 HEAD~3 HEAD

At this point I'm on a detached HEAD.

$ git status
# Not currently on any branch.
nothing to commit (working directory clean)

Let me know if you need additional information.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
