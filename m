From: Eugene Sajine <euguess@gmail.com>
Subject: Re: feature "git tag -r" to show tags and commits they are pointing 
	to
Date: Thu, 22 Oct 2009 22:30:37 -0400
Message-ID: <76c5b8580910221930s4b31b180t8298c262d9d9f421@mail.gmail.com>
References: <76c5b8580910221424n220449b9vda26f032174b6fa7@mail.gmail.com>
	 <7vr5svf6x9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 04:31:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N19vl-0005zN-3Z
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 04:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbZJWCae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 22:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbZJWCae
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 22:30:34 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:47091 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbZJWCad (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 22:30:33 -0400
Received: by gxk8 with SMTP id 8so9741791gxk.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 19:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=H8auP/pK3lHo8n/v4NjzF2GTqS0YyjTEWwPqbhCgf6c=;
        b=npzY+jrKzfUkB1FF3Vg/E54eCK3hsTKK8tH8NCgMAeH5A7LnXat3CzrYZKNNqHbzeN
         VyVbO7CDnSjuKZWBHamb7BhqTsD/k0kLCqJgZaWeIQ3cQsjpp507ZtO7Wch1rS+8d5Hv
         G+b8XOGWV5sjC976NKjFW4Ao4XKfSkX5i1c88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hGXD45S32ruiRyv8HdonZ/f3Zn9ZGjKAdTLcXSmhUjuPWMZwv1Df+xYfHmHdz6CMCZ
         vwvgQcZilq+QAt9Jd1q13U0DAw7cUU4B0/mquJBNFFidN3ZHpT2yoUiqyz5vyLSRtkZa
         pZvCztajjb187+nB1obGPyM/No7Ppe0jzvNjU=
Received: by 10.91.143.18 with SMTP id v18mr13239165agn.71.1256265037916; Thu, 
	22 Oct 2009 19:30:37 -0700 (PDT)
In-Reply-To: <7vr5svf6x9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131082>

Please, disregard...

I was looking for this info in order to create second tag for the same
commit. For example if the first tag created by somebody or
automatically (CI, release system), so i could add a verbose tag.

But i just realized that i don't need commit id for that - just tag
the tag, stupid...

Thanks,
Eugene


On 10/22/09, Junio C Hamano <gitster@pobox.com> wrote:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> Hi,
>>
>> Currently there is no way you can get the commits your tags are
>> pointing to by using git tag.
>> The only way i found is to use rev-parse (which is by the way not
>> supported by the bash_completion)
>>
>> It seems reasonable to have upper level command like:
>>
>> $ git tag -r
>>
>> to output
>>
>> v0.1  8794hke84f9e8h9ef9eh949793...
>> v0.2  jhkd934398e9f499f47w9789o97...
>>
>> $ git tag -n -r
>>
>> v0.1 "super message"     8794hke84f9e8h9ef9eh949793...
>> v0.2  "another message" jhkd934398e9f499f47w9789o9f...
>>
>> $ git tag -r v0.2
>> v0.2  jhkd934398e9f499f47w9789o9f...
>>
>>
>> What do you think?
>
> Not intereseted at all, as this does not look anything more than "because
> I could", not "because this is useful and sorely lacking".
>
> The "super message" and such are actually useful to humans, but "v0.1" is
> much more useful than 8794hke to humans, and these tag names are just as
> usable as the hexadecimal commit object names to the tools.  You can say
> "git show v0.1^0" and "git show 8794hke" and get the same thing.
>
> Heck, "8794hke" is not even hexadecimal, and the fact that you did not
> even notice it is a _S*RE_ sign that they are not useful to humans.
>
> If you _are_ a human, that is ;-)
>
> In other words, please do not justify such a proposal with "I want to have
> 'git tag' command to show the commit object name".  Rather, justify _why_
> (1) you _need_ to show the commit object name to begin with, and (2) the
> output _has_ to come from 'git tag' and not 'git rev-parse'.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
