From: Dan Loewenherz <dloewenherz@gmail.com>
Subject: Re: Bizarre behavior on git commit
Date: Wed, 5 May 2010 20:32:35 -0700
Message-ID: <n2m6f5a4e781005052032sf47733ebwf490e0369bebd03f@mail.gmail.com>
References: <s2t6f5a4e781005042246sb9ef3d48j134b22b5b41133ed@mail.gmail.com> 
	<20100505060110.GA21260@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 05:33:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9rq6-0007fD-G8
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 05:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab0EFDdN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 May 2010 23:33:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40156 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab0EFDdM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 May 2010 23:33:12 -0400
Received: by wyb35 with SMTP id 35so866036wyb.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 20:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=UsulLMWBwCbW+QvNO0F1KUvMuywg733zuKU4xY+Hv/U=;
        b=OFcY9K1GbLt4/TGq67dQ+SIgc5+am3FMPyJpxiNagd7eEpy3Mh1onj7RKdsVaiP94V
         Tl3vhFoGK1MXlcmgujykf026NdfqZ54N2bRXzQ4ufhlfZijSf+rOzjt1kF3NBLScjA+r
         l9hVVY+vws4ih9fZkF7dY0e+jRmrGOKzYEKhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZyCc+7qg8cYwWh4n+WXAvYnqXIzWYj818ANsR/0/QkdCGrq9y1fAr1nngGhIEIMgwY
         oGhAR2zX4yeeM2S9YKFWZBE1ME6mQA6JBsFE70litM37rYyXOGy7mlTQ3A3NA9QYDhRS
         j1DWbZTGvvAcjJovBPEpEbDsyL9KYY+llJMNw=
Received: by 10.216.166.3 with SMTP id f3mr549592wel.217.1273116775368; Wed, 
	05 May 2010 20:32:55 -0700 (PDT)
Received: by 10.216.52.83 with HTTP; Wed, 5 May 2010 20:32:35 -0700 (PDT)
In-Reply-To: <20100505060110.GA21260@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146433>

On Tue, May 4, 2010 at 11:01 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Dan Loewenherz wrote:
>
>> I'm running into a weird issue in a specific repo where "git show-re=
f"
>> usage is being displayed after invocating "git commit".
>>
>> E.g.
>> $ git commit -m "my commit message"
>> usage: git show-ref [-q|--quiet] [--verify] [--head]
> [...]
>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0show refs from stdin that aren't in local r=
epository
>>
>> [master 28a735f] my commit message
>> =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
>> $
>
> Strange. =C2=A0Maybe a hook script?

The GIT_TRACE helped--it was a hook script. The script's been in my
local repo for quite a while, strange that it only started having this
behavior recently. Removed the script and all works normally.

Thanks for the suggestion!

-Dan
