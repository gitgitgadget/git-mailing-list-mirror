From: skillzero@gmail.com
Subject: Re: git cherry to find equivalent commit IDs?
Date: Thu, 13 Aug 2009 16:05:45 -0700
Message-ID: <2729632a0908131605p62b5e7ddjef9732baea0be84d@mail.gmail.com>
References: <2729632a0908131413w1a2efca8t31ac8cc43e1d6888@mail.gmail.com>
	 <32541b130908131437g7cb14a1eh6cd2e31a57f105d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 01:05:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbjMo-0006z8-35
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 01:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbZHMXFq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 19:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754796AbZHMXFp
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 19:05:45 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:61175 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbZHMXFp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 19:05:45 -0400
Received: by qw-out-2122.google.com with SMTP id 8so397789qwh.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 16:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ifK/2uG0IQDf2/QOwumN3jRcCbj1sQej58Smzn+5fN4=;
        b=tLAy5zzHytReyQas3EtTnx+VrWez1mfQuN34lc7RnX5JnHVCIMlj7NvUvfUS83jP3v
         bQtLlMJpRSju5RtKlmm3HdJR87yvJWgOHsRVcyetXWk5xkzR06J+I4st70EHmBP9/Jtd
         1IfhoPuZvgraAIqbQ4ssJUqIZclaoc3OBvpKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fB3fHcrmKrpJZUSPqqKDtClR20DyCxq9UyAuBv9UtgVdJdtlSAqFdOPLejbWiAAJqu
         B0Gwo3C/8anU9Ni/S2u/cKieY91FfBhhqcyanlahbTtu4uueLCkWl6jkyUTB2LplQ0ij
         0cThFyb5uzl1wCyfPQWQJdyblYSMvH86GdSnY=
Received: by 10.224.108.5 with SMTP id d5mr1788155qap.294.1250204745818; Thu, 
	13 Aug 2009 16:05:45 -0700 (PDT)
In-Reply-To: <32541b130908131437g7cb14a1eh6cd2e31a57f105d5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125891>

On Thu, Aug 13, 2009 at 2:37 PM, Avery Pennarun<apenwarr@gmail.com> wro=
te:
> On Thu, Aug 13, 2009 at 9:13 PM, <skillzero@gmail.com> wrote:
>> For example, commit 3642151 on branch A was a cherry pick of a commi=
t
>> 460050c on master:
>>
>> $ git branch -a --contains 3642151
>> =C2=A0A
>>
>> $ git branch -a --contains 460050c
>> * master
>>
>> $ git cherry -v master 3642151
>> - 3642151435ce5737debc1213de46dd556475bfad1 fixed bug
>>
>> I assume that means an equivalent change to 3642151 is already in
>> master (which it is, as commit 460050c). But I want to find out the
>> commit ID on master that's equivalent to 3642151 (i.e. something tha=
t
>> tells me it's 460050c).
>
> git show 3642151 | git patch-id
>
> You should get a line with two hashes; the first is the patchid (call
> it PATCHID_FROM_ABOVE)
>
> git log -p | git patch-id | grep PATCHID_FROM_ABOVE
>
> This should give you a list of all commits that correspond to that pa=
tchid.

That worked perfectly. Thanks.
