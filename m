From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/5] gitweb: Add a comment explaining the meaning of $/
Date: Wed, 4 Dec 2013 18:37:59 +0100
Message-ID: <CANQwDwdUY7FunkZEsAn5PuXH+e1yBL7mfA2vTdQwfOTTmAh+ig@mail.gmail.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
 <1386164583-14109-2-git-send-email-krzesimir@endocode.com>
 <CANQwDwdiNHFCChVdkKxkEa+HOKzzhgfzy4d6iZB6ejSfva3Z3A@mail.gmail.com>
 <1386171977.2173.23.camel@localhost.localdomain> <CANQwDwfiYAz7dro9mppR62xEFMPTSNjEKYM=7Dhq7auBvyXjSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 18:38:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoGPN-0003AT-68
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 18:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517Ab3LDRil convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 12:38:41 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:50730 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab3LDRik convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 12:38:40 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so14071545wgh.26
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 09:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7hXj+Zy3c9scZzoSfCn8couypX2STar7zkI91WZDOD4=;
        b=qzEZVpOKs/l345M7AG3Uf4QS1YGqxz10/bP7LRP9WWuvT4narQOWSvR1X1pHhIpvoy
         HsBHuWJzncVW5Ndb0Z5gXeim3FXzIM2L7RipEF9npXFiofl3hwqMU+aShiJj4oTKhJw1
         Ur5ryxw1PHru53qS0eiiJ+PpgLBx5Z8UhGjAZafd0CfFGms4WgUZFJ/xnjmjWU37gm7G
         /jd+fioMMIEmOJPOmk68f9yFIFvOsrHB4W6YyThmvlHv5ALZsFCqzb1cM404DMJZDqqy
         GIma0O/wKAEHuTGx3DNrgWJkHQTuH1EiQrKXo4gISS6+NjCq9fhB2aNb4cAbkb1IL8hS
         sDQA==
X-Received: by 10.194.237.99 with SMTP id vb3mr65484269wjc.28.1386178719715;
 Wed, 04 Dec 2013 09:38:39 -0800 (PST)
Received: by 10.227.108.131 with HTTP; Wed, 4 Dec 2013 09:37:59 -0800 (PST)
In-Reply-To: <CANQwDwfiYAz7dro9mppR62xEFMPTSNjEKYM=7Dhq7auBvyXjSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238793>

On Wed, Dec 4, 2013 at 6:34 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
> On Wed, Dec 4, 2013 at 4:46 PM, Krzesimir Nowak <krzesimir@endocode.c=
om> wrote:
>> On Wed, 2013-12-04 at 16:11 +0100, Jakub Nar=C4=99bski wrote:
>>> On Wed, Dec 4, 2013 at 2:42 PM, Krzesimir Nowak <krzesimir@endocode=
=2Ecom> wrote:
>>>
>>> > So future reader will know what does it mean without running "per=
ldoc
>>> > perlvar".
>>>
>>> Hmmm... shouldn't future reader know it anyway?  It is not that cry=
ptic.
>>> I'd say it is idiomatic Perl.
>>
>> It's plainly obscure. And I think it is not that often used - I keep
>> forgetting what that pair of punctuation is actually meaning.
>
> I think it depends on what kind of Perl code one is used to. It is no=
t
> as obscure as $; and similar to $|, I think.
>
>> In this case I guess it would be more readable to use the following =
code
>> instead:
>>
>>    $fh->input_record_separator ("\0");
>
> That would be a good change to replace
>
>         local $/ =3D "\0";
>
>         open my $fh, "-|", git_cmd(), ..., '-z', ...
>
> with
>
>         open my $fh, "-|", git_cmd(), ..., '-z', ...
>         $fh->input_record_separator ("\0");
>
> (not forgetting about "use IO::Handle", which module is core Perl mod=
ule);

Actually it is replacing

         local $/ =3D "\0";

with

        IO::Handle->input_record_separator("\0");

see http://p3rl.org/IO::Handle
