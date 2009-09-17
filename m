From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Update the usage bundle string.
Date: Thu, 17 Sep 2009 12:56:24 -0300
Message-ID: <a4c8a6d00909170856t69695a33u86fbc7bc1d9a008@mail.gmail.com>
References: <1253136011-12011-1-git-send-email-tfransosi@gmail.com>
	 <4AB1D364.1080701@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 17:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoJLb-00043h-QP
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 17:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757951AbZIQP4X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2009 11:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757788AbZIQP4W
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 11:56:22 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:62700 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757630AbZIQP4U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2009 11:56:20 -0400
Received: by an-out-0708.google.com with SMTP id d40so651070and.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 08:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rPxVUjF4hJJtZ9gCsUnEGvPUF8RQ9oVNBwQT8StCBqE=;
        b=mnJwAINzvFumULc3cVC7dWRYuGI10HWHfL3PCXD00RPwvD3PGBQkEOYrCm0Nv5Cw3e
         KQa17dtQg03OdTe+Cd55pjbd/EqvG0tt/TfGSxKGNybN0hti+Fj3CV5fwk0+fFbZwJsM
         kNgbRxrGjdii6xO7VAD9VbkOCs4JZoUQgzOrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bNl5nFl+E7fg5NGAS5jEhU/tXXdaw0ygS8zqbEfzcxivl52orytx7hucpShDjrq+9h
         VksGM7tseOgoPhXa8H9xYOzkb9gq5SflCX/hZpXO6EaKFYy7Czya+syb1J6FbFebTxxC
         6s8c58RW9mWK6muWhSX99BUshABTMcL4lLQmg=
Received: by 10.101.27.32 with SMTP id e32mr273861anj.55.1253202984340; Thu, 
	17 Sep 2009 08:56:24 -0700 (PDT)
In-Reply-To: <4AB1D364.1080701@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128761>

On Thu, Sep 17, 2009 at 3:12 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Thiago Farina schrieb:
>> @@ -11,6 +11,12 @@
>>
>> =A0static const char *bundle_usage=3D"git bundle (create <bundle> <g=
it rev-list args> | verify <bundle> | list-heads <bundle> [refname]... =
| unbundle <bundle> [refname]... )";
>
> Is this variable still used? Shouldn't it be removed?
Yeah it should be removed, I did this in the third email that I sent.
To send another revision of the patch I'm doing this:
$ git commit <filename> --amend
$ git format-patch -1 --subject-prefix "Patch vN"
But I'm not sure if this is the correct away to send another set of
changes of the same patch. Is right?
>
>> +static const char builtin_bundle_usage[] =3D "\
>> + =A0git bundle create <file> <git-rev-list args>\n\
>> + =A0git bundle verify <file>\n\
>> + =A0git bundle list-heads <file> [refname...]\n\
>> + =A0git bundle unbundle <file> [refname...]";
>
> You indent the usage text. Do other commands do that, too? If you res=
end,
> it may be worth using this style:
>
> static const char builtin_bundle_usage[] =3D
> =A0 =A0 =A0 =A0"git bundle create <file> <git-rev-list args>\n"
> =A0 =A0 =A0 =A0"git bundle verify <file>\n"
> ...
>
> i.e. not to use backslash-at-eol.
>
Sure, I will update it to use this style. There is another usage
string that uses backslash-at-eol, it is in builtin-pack-objecs.c .
Should I update this string too?
>> - =A0 =A0 if (argc < 3)
>> - =A0 =A0 =A0 =A0 =A0 =A0 usage(bundle_usage);
>> + =A0if (argc < 3)
>> + =A0 =A0 =A0 =A0 =A0 =A0 usage(builtin_bundle_usage);
>
> This re-indentation is an accident, isn't it?
Was an accident, sorry about that. I configured my editor to use 2
spaces per indent, tab size 2 and expand tabs to spaces. Git uses 4
spaces per indent and tab size 4?
>
> -- Hannes
>
>
