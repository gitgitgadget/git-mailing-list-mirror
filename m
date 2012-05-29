From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for
 translation
Date: Tue, 29 May 2012 15:37:59 -0500
Message-ID: <20120529203759.GC22151@burratino>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
 <7vr4u23f0i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 29 22:38:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZTBH-0004lE-4A
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 22:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843Ab2E2UiL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 16:38:11 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60406 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719Ab2E2UiJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 16:38:09 -0400
Received: by obbtb18 with SMTP id tb18so7348238obb.19
        for <git@vger.kernel.org>; Tue, 29 May 2012 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hRTlvMkFwZPJDPM4DWrNe3sp478iFOlS7LCf346eK7c=;
        b=wPj7G294htrHMjgIqFtKH0YL1Jam/Pcjc1sTCbGS/Xyueu6TP8IKbv9l0+xtN5xFMM
         s/DnIKALKEMy4qUzFO/l3WbjFAa04LFTvjyhCV+7mNZw8GwEbE0h6u2E5PnbljuwMTfk
         WHiUB3I2A85zu3SPoSaAQhRhtroNTRzmoJWxbAsMUzAO/zjR0ZiBQmBuxF+Av/a4SeHq
         l16mOcu343vaJ017JLAh5vL/Ku+MvvQXUSoiP7+U5/LwEOhzN0H9Gbq+vYPTWA7QcJPv
         YGxM+MGMB+bYI4iGqEDbfW0Ye9HgqGboYLmebDdOrEntEBlIBvmvJEhk+wayIYachlZR
         fLWQ==
Received: by 10.182.154.73 with SMTP id vm9mr2350055obb.72.1338323889116;
        Tue, 29 May 2012 13:38:09 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id r8sm9586533oer.6.2012.05.29.13.38.08
        (version=SSLv3 cipher=OTHER);
        Tue, 29 May 2012 13:38:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vr4u23f0i.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198759>

Junio C Hamano wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:

>> --- a/archive.c
>> +++ b/archive.c
>> @@ -7,10 +7,10 @@
>>  #include "unpack-trees.h"
>> =20
>>  static char const * const archive_usage[] =3D {
>> -	"git archive [options] <tree-ish> [<path>...]",
>> -	"git archive --list",
>> -	"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [=
<path>...]",
>> -	"git archive --remote <repo> [--exec <cmd>] --list",
>> +	N_("git archive [options] <tree-ish> [<path>...]"),
>> +	N_("git archive --list"),
>> +	N_("git archive --remote <repo> [--exec <cmd>] [options] <tree-ish=
> [<path>...]"),
>> +	N_("git archive --remote <repo> [--exec <cmd>] --list"),
>>  	NULL
>>  };
>
> I can understand the "help" text member of OPT_BLAH() construct, but
> do we really want to translate the above?

<repo>, <cmd>, [options], <tree-ish>, and <path> may be spelled
differently in other languages.  Would it be possible to take care
of this kind of substitution automatically?

At least "git archive --list" should probably be kept untranslated
to lessen the translator workload a bit.  Good catch.
