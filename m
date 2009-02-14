From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 03:52:56 -0800 (PST)
Message-ID: <m3skmhteuk.fsf@localhost.localdomain>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 12:54:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYJ6L-0004Uw-CO
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 12:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbZBNLxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 06:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbZBNLxA
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 06:53:00 -0500
Received: from mail-bw0-f167.google.com ([209.85.218.167]:32957 "EHLO
	mail-bw0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbZBNLw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 06:52:59 -0500
Received: by bwz11 with SMTP id 11so1007821bwz.13
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 03:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=HpPx9+saU8lj9qcd/7eZ5bBGZzShWuwPQq3r1DtwF6U=;
        b=EqtmpL0S87mWcl4cxMG36CcynjKzt5a+8iwoKEK3g4QpERskDGNRMt8uN0e7SyeQAK
         xPthhvvZB+HfOhyGn41Wac+2iNVShxsewsTBGBa3fjZ+WO6FvWuR1usWtojF5mNyZ67R
         TB6tyCIJgzURH7XZdK70kDhjEnSvFclfRHPk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=VmG/H3MF0qWxZKIBYsDhSjFUFQbkEQgun99FTwkQf+M7nJEUlArKBxGBwlyVswjWLE
         EYQtmy1D32jsnC7zgSysqXaWhWgAtZuVMHbbUHt8gvXpaqG8Ck6UJClYq+hr6q63j31P
         EGBLibB6cEtlrkaNmizAbDqlY+Fnpe08k8F/A=
Received: by 10.103.222.1 with SMTP id z1mr269872muq.51.1234612376628;
        Sat, 14 Feb 2009 03:52:56 -0800 (PST)
Received: from localhost.localdomain (abwj21.neoplus.adsl.tpnet.pl [83.8.233.21])
        by mx.google.com with ESMTPS id j2sm1647568mue.54.2009.02.14.03.52.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Feb 2009 03:52:56 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1EBqrtQ025292;
	Sat, 14 Feb 2009 12:52:54 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1EBqqWJ025289;
	Sat, 14 Feb 2009 12:52:52 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109864>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Reorganizing the code to use parseopt as suggested by Johannes
> Schindelin.

[...]
> -static const char git_config_set_usage[] =
> -"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --edit | -e ]";
> +static const char *const builtin_config_usage[] = {
> +	"git config [options]",
> +	NULL
> +};

Just asking: why this change?

> +	OPT_BOOLEAN('z', "null", &end_null, "end values with null character"),

Terminate and NUL.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
