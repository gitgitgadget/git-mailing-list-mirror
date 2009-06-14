From: Marco Nelissen <marcone@xs4all.nl>
Subject: Re: running git as root
Date: Sun, 14 Jun 2009 14:40:19 -0700
Message-ID: <3a3d9e520906141440p720df7c1l6e25b71899daaa7c@mail.gmail.com>
References: <3a3d9e520906130825k25815c9atafde301d9fbc1da2@mail.gmail.com>
	 <81b0412b0906131049v60cfbc9bm3fd26cc25acc2cd4@mail.gmail.com>
	 <20090614150851.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 23:40:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFxRE-00067D-Ul
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 23:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757049AbZFNVkU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jun 2009 17:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756442AbZFNVkT
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 17:40:19 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:57324 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453AbZFNVkR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2009 17:40:17 -0400
Received: by an-out-0708.google.com with SMTP id d40so7778379and.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 14:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=9FzFX1FLvNbYWVFj4djiqu3qAydgjwNuY2j5vnL0iDM=;
        b=l7xB9eBQqxeMlBRhJjuxQAhdtHt0QsISI6SjtlEoljY22vFdqze6rf2rYZWqLle0wo
         1HelZhAxaOrTatCMUYSPQ+rmWQYuNT83XyQELEBhx3v13sM9uXlAhB90nWI5JVOWiNgz
         RJJhlBlAUs+mh9GX2Ze9sOehowi6rvsOPB4W0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=AX1cVQLF8X418Xc0StufEdgv0FKhs4rLeyXTqvSWgEcYESRkiYgj0cP4/nvp4hus1d
         JbXG1niocPd3icJdsaFqEVZ1eEnJYVYOEDFUsjPcpVo6mph45rEej1p6qzRAGjblB7jM
         RzSFM9h5YFtnQfcm1OqZ87W1iFZLvZmBhMB84=
Received: by 10.100.138.10 with SMTP id l10mr7860637and.61.1245015619402; Sun, 
	14 Jun 2009 14:40:19 -0700 (PDT)
In-Reply-To: <20090614150851.6117@nanako3.lavabit.com>
X-Google-Sender-Auth: f8f92bc48552fecb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121564>

On Sat, Jun 13, 2009 at 11:08 PM, Nanako Shiraishi<nanako3@lavabit.com>=
 wrote:
> Quoting Alex Riesen <raa.lkml@gmail.com>:
>
>> 2009/6/13 Marco Nelissen <marcone@xs4all.nl>:
>>> When running as root, git fails a number of test cases that expect =
it
>>> to fail on read-only repositories (for example 't0004-unwritable.sh=
').
>>> I was thinking of either changing the code so that it checks
>>> permissions itself when opening files as root, or add a prerequisit=
e
>>> to those test cases so that they are skipped when running as root.
>>
>> There is such a prerequisite already (POSIXPERM), but what caused
>> you to run the _tests_ as root?
>>
>>> What would be the preferred way?
>>
>> Use the prerequisite would sound right when not the
>> strangeness of the idea.
>
> I think somebody needs to repost an old patch from the archive.
>
> =C2=A0 =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/1=
16729/focus=3D118385

That's almost identical to the patch I wanted to submit, except for
the name 'SANITY', which doesn't make much sense I think.
