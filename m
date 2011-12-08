From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 04/15] t1007 (hash-object): fix && chaining
Date: Thu, 8 Dec 2011 10:12:18 +0530
Message-ID: <CALkWK0nDqbzkbsCqeqQ4ywvnR-t1KapxBZsSWJLu+1K+UDQGzg@mail.gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com> <1323286611-4806-5-git-send-email-artagnon@gmail.com>
 <20111207214716.GA2911@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 05:42:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYVok-0003qG-HI
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 05:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab1LHEmm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 23:42:42 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34162 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855Ab1LHEmk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 23:42:40 -0500
Received: by qadb40 with SMTP id b40so242347qad.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 20:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=a9KImU71568Y1vmgtA47O75AYcBQbpDnu1+ostdp5OM=;
        b=qm7IO9WGliP5oncgoOwU2+yI2BXveel4Nr6rILcPElkl19LBjWvFLwILqalAJWU2SP
         NL7QyMSUYrZ1hLBZYDqAwCiLuXDq2jccw5K+XkAOh91BFm6B8KGIUNMIp6tS7XJc0Mbt
         SLLJFuaD6xBWADTQIJzG/H1iC5dP+Ss8UMJIw=
Received: by 10.224.180.131 with SMTP id bu3mr1370271qab.5.1323319359215; Wed,
 07 Dec 2011 20:42:39 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Wed, 7 Dec 2011 20:42:18 -0800 (PST)
In-Reply-To: <20111207214716.GA2911@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186531>

Hi Jonathan,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
> [...]
>
> IMHO if the patches are only being sent to me, Junio, and the
> mailing list (and not cc-ed to different people), then there's no
> reason to split them up when they have the same topic.

Right.  I'll re-roll with similar patches squashed together -- it's
easier to review and fixup in this form.

>> --- a/t/t1007-hash-object.sh
>> +++ b/t/t1007-hash-object.sh
>> @@ -154,13 +154,13 @@ test_expect_success 'check that --no-filters o=
ption works with --stdin-paths' '
>> =C2=A0pop_repo
>>
>> =C2=A0for args in "-w --stdin" "--stdin -w"; do
>> - =C2=A0 =C2=A0 push_repo
>> + =C2=A0 =C2=A0 push_repo &&
>>
>> =C2=A0 =C2=A0 =C2=A0 test_expect_success "hash from stdin and write =
to database ($args)" '
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test $example_sha1 =
=3D $(git hash-object $args < example)
>> - =C2=A0 =C2=A0 '
>> + =C2=A0 =C2=A0 ' &&
>
> I don't see how this would have any effect. =C2=A0Is it intended?

Oops, looks like I was in a bit of a rush.  Good catch.

-- Ram
