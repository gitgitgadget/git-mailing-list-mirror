From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/8] Teach git var about GIT_EDITOR
Date: Fri, 30 Oct 2009 17:47:38 -0500
Message-ID: <20091030224737.GA16565@progeny.tock>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock>
 <20091029075021.GC15403@progeny.tock>
 <7v8weu6idl.fsf@alter.siamese.dyndns.org>
 <20091030101634.GA1610@progeny.tock>
 <20091030102658.GD1610@progeny.tock>
 <4AEB51C6.7060204@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 23:37:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4068-0002Ug-2a
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 23:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932999AbZJ3WhW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 18:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932990AbZJ3WhV
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 18:37:21 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:62174 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932948AbZJ3WhU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 18:37:20 -0400
Received: by ywh40 with SMTP id 40so3129248ywh.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 15:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=2/0CoQBLAh9b4GZDzIhnD6Y2DKxAejAgwWmScAkw0+M=;
        b=GUYu0DEIRBVIkjwgCNAMojbh8ZCy+yHRZc/u2gtsqeJj8T4VWgbLyF2d5TorKpNirx
         mrrrGjuYxaOP2eg9lSYhAkUihfWy77OGrsckxQkwEkzR3cU/gFoTmgD/djIhnigjkJY3
         S3Us1YFt4f6KVUsm0P626PmS6ZRNK/bxAbr00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=BzdvE3ExxfXKS9r0Yf67w6XWfln4kwQFtuxhKx1bEfl7eHrzpv/ZtHFbmic8hIOlJ2
         PZHRkdbMlvH8fxloOhgfRWq8+D/atFf99EGqEOVQ4htivgMlfcmB3f9wiM5XktG23Yo1
         KOfVQJIqp+BIrKz8bTFgI1GXPlCL5BKiUgIDc=
Received: by 10.150.114.14 with SMTP id m14mr4071683ybc.162.1256942244952;
        Fri, 30 Oct 2009 15:37:24 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm186287gxk.1.2009.10.30.15.37.23
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 15:37:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AEB51C6.7060204@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131771>

Johannes Sixt wrote:
> Jonathan Nieder schrieb:

>> From: Johannes Sixt <j.sixt@viscovery.net>
[...]
> Thanks for cleaning up behind me. I don't mind if you take
> authorship, but if you do keep my name, please make it:
>=20
> From: Johannes Sixt <j6t@kdbg.org>

Thanks for the catch.

>>+		error(
>> 		  "No editor specified in GIT_EDITOR, core.editor, VISUAL,\n"
>> 		  "or EDITOR. Tried to fall back to vi but terminal is dumb.\n"
>> 		  "Please set one of these variables to an appropriate\n"
>> 		  "editor or run again with options that will not cause an\n"
>> 		  "editor to be invoked (e.g., -m or -F for git commit).");
>>+		return NULL;
>>+	}
>=20
> I somehow dislike that this huge error message is in git_editor().

Makes sense.

I am a bit uncomfortable with this error in general.  It makes some
sense to refuse to use $VISUAL and fall back to $EDITOR if TERM=3Ddumb,
since without this the distinction between VISUAL and EDITOR is not
very useful.  But wouldn=E2=80=99t that check be equally useful if GIT_=
EDITOR
or core.editor is set to vi?  Ideally, vi itself would check TERM and
error out, and git would only need to report and handle the exit.

Unfortunately, at least vim is happy to assume a terminal supports
ANSI sequences even if TERM=3Ddumb (e.g., when running from a text
editor like Acme).  Unless VISUAL, GIT_EDITOR, and core.editor are
unset, nobody gets the benefit of this check.

Should git error out rather than run $VISUAL when TERM=3Ddumb?  How
about $GIT_EDITOR?

The advice about options to avoid invoking an editor is not very
helpful except with 'git commit', so probably only 'git commit' should
print that message.

> The return value, NULL, should be indication enough for the callers
> to handle the situation suitable.

Good idea.

> In particular, launch_editor()
> wants to write this big warning, but 'git var -l' can avoid the
> error message and write only a short notice:
>=20
> GIT_EDITOR=3Dterminal is dumb, but VISUAL and EDITOR unset

Maybe 'git var -l' should omit GIT_EDITOR in this situation.

Thanks for the comments,
Jonathan
