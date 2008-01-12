From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 2/5] git-submodule: New subcommand 'summary' (2) - hard work
Date: Sat, 12 Jan 2008 19:12:00 +0800
Message-ID: <46dff0320801120312i7b22f13vb9fe2394b1f687a9@mail.gmail.com>
References: <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
	 <62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 12:12:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDeI2-0004kK-0h
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 12:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762001AbYALLMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 06:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761909AbYALLME
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 06:12:04 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:63536 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761794AbYALLMB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 06:12:01 -0500
Received: by py-out-1112.google.com with SMTP id u52so2092205pyb.10
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 03:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YGdvmYbnDPwmF3xawq3QcNRB80TuCp3DrdPpcDCg6qQ=;
        b=EorHUtKVKrnLzISUTYDWgw4gjCQ/05CWjVoRPwyD7uBsym8FLGDiLdArkobU814d7IW2QMOVcuGK44kNTNUfcojpgjg2pMWPa+fKjp/9T5N1v3Q4axUkGfMTmamSyliXoQBohVs3FxPcRI0Uo6uxqXE8yrSMfh2bZu1XQlyqEzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=x7yNGuS8Tf3DJBXyxABVEivWojySW24M6CMCYZ9ByQCfGWOf6gs2WskQqcHkz/SdvTcg+KX1jWo6CA2LOYdKNODi9FWXK6noQcQeT5jw2ktvnAZzIQe+fteWoTKAuo/jEZNG8UC5W7H9DaC08OCagmJTaQak0iG6mAPJKQtgbMI=
Received: by 10.35.127.9 with SMTP id e9mr4914006pyn.21.1200136320538;
        Sat, 12 Jan 2008 03:12:00 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 12 Jan 2008 03:12:00 -0800 (PST)
In-Reply-To: <62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70308>

> +                       echo "* $name $sha1_src...$sha1_dst:"

If it's a type change (head submodule but index blob, or the the
reverse), $sha1_dst or $sha1_src will be the sha1 of the blob. It's
inapprociate to be shown as if it's a commit in the submodule. May
00000000 should be shown instead of the blob sha1? However, any good
way to tell user the type change info? Is it ok to add an additional
line such as ""Add file sm1"  in the summary and also change the
summary description as follows?

-------------------------------------------------------------------------------------
 $ git submodule summary sm1
 # Submodules modifiled: sm1
 #
 # * sm1 354cd45...0000000(3f751e5):
 #   <one line message for C
 #   <one line message for B
 #   >Add file sm1
-------------------------------------------------------------------------------------



> 1.5.4.rc2.9.gf5146-dirty
>
>



-- 
Ping Yin
