From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Problems after deleting submodule
Date: Wed, 19 Oct 2011 11:23:11 +0100
Message-ID: <CAHVO_919up2OBtWDA5cvhOSzmN0QJG3FpxBi7D5_qLbtw3ETbg@mail.gmail.com>
References: <CAHVO_90UN_nNDbqxM2TkUjo_qfVhLgjUJoZTmYi6rsLnRMOUFg@mail.gmail.com>
	<4E9DD9E0.80808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 19 12:23:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGTIs-0008I5-L1
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 12:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab1JSKXN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Oct 2011 06:23:13 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45515 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab1JSKXM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2011 06:23:12 -0400
Received: by qyk27 with SMTP id 27so1453134qyk.19
        for <git@vger.kernel.org>; Wed, 19 Oct 2011 03:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vqaQEWfOudsvEbNNGkI96SoIcpjNUp/DaAaqPzTHnfE=;
        b=fgcLF5HnoplKnrgCzK82uJwuNBFLUt4NhcA2SyqQLzMBNf6QMth05vxjkarrU/Fe3H
         BVpzgV8vm+v/PLd60Onrigfu/kidTHpiweeAtS+PxcMnhwZ2c2Nv0x+KIJu3+0evfOvc
         tZkFUfzkcIRHNZBOHoVNgXUbANq2cvSzA9XAQ=
Received: by 10.229.186.208 with SMTP id ct16mr1322440qcb.194.1319019791917;
 Wed, 19 Oct 2011 03:23:11 -0700 (PDT)
Received: by 10.229.211.73 with HTTP; Wed, 19 Oct 2011 03:23:11 -0700 (PDT)
In-Reply-To: <4E9DD9E0.80808@web.de>
X-Google-Sender-Auth: efCXiCx42G68eXwtIDl2I2Ljfq8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183927>

On 18 October 2011 20:56, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 18.10.2011 13:54, schrieb Howard Miller:
>> I included a submodule in my project then decided I didn't like
>> submodules and deleted it again. I followed the advice of delting
>> .gitmodules, the bit from .git/config and then git rm'ing the
>> submodule. Seemed to work. I then copied files with the same directo=
ry
>> name into where the submodule was. However, I can't add them.
>>
>> Doing git add /path/to/old/submodule - does nothing, files are not
>> staged, no error messages no nothing.
>> If I try to git rm /path/to/old/submodule - it just says 'did not
>> match any files'.
>>
>> It simply does not seem to want to add anything to the old submodule
>> location. I had a grep around and could not see any obvious referenc=
es
>> in the repo.
>>
>> I'm a bit stuck... any suggestions for things I can try much appreci=
ated.
>
> Looks like the gitlink entry of the submodule is still there. I assum=
e
> =A0 =A0 =A0 =A0git ls-files --stage | grep 160000
> still shows the submodule? That would make it impossible to add anyth=
ing
> in the former submodule directory.
>
> When I delete .gitmodules and the .git/config entry and do a
> =A0 =A0 =A0 =A0git rm sub/
> I get
> =A0 =A0 =A0 =A0fatal: pathspec 'sub/' did not match any files
>
> If I omit the trailing slash it is:
> =A0 =A0 =A0 =A0fatal: git rm: 'sub': Is a directory
>
> I have to do a
> =A0 =A0 =A0 =A0rm -rf sub
> followed by
> =A0 =A0 =A0 =A0git rm sub
> to get everything cleaned up.
>
> Does that help you?

Yes - that was exactly the problem. I'm slightly embarrassed I missed
that. For some reason the initial delete of the submodule left the
empty directory in place (could have been a mistake on my part). I
didn't notice when I copied the new files back but it was enough to
break it.

I can't help thinking there could be some warning when doing an 'add'
but I don't think I have my head around it enough :)

Anyway, thanks for the help (again) everyone!
