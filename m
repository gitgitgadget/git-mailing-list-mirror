From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3] git apply: option to ignore whitespace differences
Date: Fri, 31 Jul 2009 21:22:09 +0200
Message-ID: <cb7bb73a0907311222h49caf016pb9b4a4fd2bd766a@mail.gmail.com>
References: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vljm84htf.fsf@alter.siamese.dyndns.org> <cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com> 
	<20090729174000.6117@nanako3.lavabit.com> <94a0d4530907301727h171a2581ybee2a5b2d77e7c05@mail.gmail.com> 
	<7v3a8d65kv.fsf@alter.siamese.dyndns.org> <94a0d4530907310838nbca0037u1a192dc07a379e66@mail.gmail.com> 
	<cb7bb73a0907310916i309c99cax2f2d5aa02084103f@mail.gmail.com> 
	<7v1vnwsreu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 21:22:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWxgc-000517-Hs
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 21:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbZGaTWb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 15:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZGaTWa
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 15:22:30 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46644 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbZGaTWa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 15:22:30 -0400
Received: by bwz19 with SMTP id 19so1370862bwz.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=TeaNgxPsfJJnBSi5q9iG9K8spe1eTtnxeh7mvUzJIOM=;
        b=cAiRv2fb7TGa+VfuAwiQ8HAROHesHhMSQlcnwJfIoRNUYfbz0BN6F4yslJuSZb2dAy
         0RoDuJDPP4FTaEUg5oA49LqdIbyXB6DAe2X5/LKHOHHY1c92IF++Gqfv1NmuNd36Ihd/
         7D9YgqWWKwjNy3lbjLhl1q3k8mwbkaCPFkAxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oDols6I8diw7Kwb9MDkd9ZY4fFjqZdTGvW0dqX+6xQSjx6L9LhkNOGoh2uDcKBvlHc
         0s/kpD+L2Vy+RZepaBpAhBVsFmmhb9VAW/HWLiVQxLIE8FD6jZoMle/GfH+Q0N3Ohhy7
         Bx7POpl1uy3IVFLDqoF9vOv7Bu4TyXTTw0bQ4=
Received: by 10.204.101.142 with SMTP id c14mr2827231bko.87.1249068149096; 
	Fri, 31 Jul 2009 12:22:29 -0700 (PDT)
In-Reply-To: <7v1vnwsreu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124595>

On Fri, Jul 31, 2009 at 7:17 PM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> Before I go on with the next revision of the patch, I would like to
>> have some kind of agreed convention to implement.
>>
>> My suggestion would be the following:
>> (1) implement options --ignore-space-change, --ignore-all-space
>> mirroring their 'git diff' meaning.
>> (2) add --ignore-whitespace as a synonym to --ignore-space-change, f=
or
>> consistency with 'patch'
>> (3) apply.ignore-whitespace accepts values
>> =A0 =A0 =A0* false,no,none,0 to mean no whitespace ignoring
>> =A0 =A0 =A0* true,yes,change,1 to mean ignore whitespace change
>> =A0 =A0 =A0* all,2 to mean ignore all whitespace
>
> I'd suggest taking one small bite at a time.

Sure.

> A later follow-up patch would complete your (1) and (2) by supporting
> ignore-all-space. =A0And perhaps you would give it --ignore-all-white=
space
> synonym perhaps? =A0You may want to ask "GNU patch" people if they ar=
e
> interested in ignoring all whitespaces, and if so what their plan is =
to
> name that option, so that you can use the same name.

I was thinking about making --ignore-whitespace (I'd rather keep the
-- because that's what patch goes for) accept an optional argument,
allowing e.g. --ignore-whitespace=3Dno to overrule the config option. I=
n
this case we would have --ignore-whitespace=3Dall as synonym to
-ignore-all-space. It would also make the --ignore-whitespace option
more in line with the ignorewhitespace config

--=20
Giuseppe "Oblomov" Bilotta
