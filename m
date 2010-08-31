From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 05/17] gettext: make the simple parts of git-init
 localizable
Date: Tue, 31 Aug 2010 10:03:01 -0500
Message-ID: <20100831150301.GE2315@burratino>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <1283203703-26923-6-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:05:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqSOb-0002yI-MK
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342Ab0HaPEx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 11:04:53 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36695 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932277Ab0HaPEx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 11:04:53 -0400
Received: by vws3 with SMTP id 3so5428977vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ykibl0Y7X0DGuoHsy+VVux2A1LUuVbWk4F2esYwk9HY=;
        b=YFl8LJ4i5fzg4lMfbpaRe1pK1XrA2BAfZlapDQ1JeQYmInyKB7vDZfyh1cSsOepHRp
         TvNtwG/0R/hKY0sMNfdpGgpIAjK42Gxh68Tg5VjkWU9lbQBtaJeSoLqiG0TIF9KhnhPj
         YYKEgrzC8PsWiHD0+2BfLAosee7Jy80yQ8nZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hcdVeG3+hjdGZD/kQFRSfeoOKH6AUSEm/yQaNDlfhVJsvJRUeuzyw4F8KXwDf/ZuwA
         ASx+MBVrxEct+Q3xONIsx/LDWTkuZeChWMkqZdK6SAZGZyNp0hxQXYrePutb8MNIPgy2
         fx4ypAqltqw7BAP2+2pu+xqmcpAF+S54V/Sac=
Received: by 10.220.62.72 with SMTP id w8mr2865663vch.69.1283267090722;
        Tue, 31 Aug 2010 08:04:50 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id b8sm2880247vci.21.2010.08.31.08.04.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 08:04:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283203703-26923-6-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154907>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -31,7 +31,7 @@ static void safe_create_dir(const char *dir, int sh=
are)
>  		}
>  	}
>  	else if (share && adjust_shared_perm(dir))
> -		die("Could not make %s writable by group", dir);
> +		die(_("Could not make %s writable by group"), dir);

Sensible.

I wonder if die() should not just be taught to automatically look up
translations for its format string (could gettext handle that?).

Although we try not to change plumbing error messages without good
reason, details of error messages change often enough that imvho
scripts should not be relying on them.

> -				die_errno("cannot stat '%s'", path);
> +				die_errno(_("cannot stat '%s'"), path);

Will strerror() cope correctly without LC_CTYPE set up?  (Not part
of this series, just something I was reminded of.)
