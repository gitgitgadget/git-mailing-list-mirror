From: Matt McClure <mlm@aya.yale.edu>
Subject: Re: [Vcs-fast-import-devs] What's cooking in git.git (Oct 2009, #01; 
	Wed, 07)
Date: Sun, 11 Oct 2009 07:40:27 -0400
Message-ID: <e48c5e540910110440k33e3d0dcp6d8c1480b5848366@mail.gmail.com>
References: <7viqeqjsx6.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.1.00.0910080848380.4985@pacific.mpi-cbg.de>
	 <fabb9a1e0910072349q68d6756cgebb041a0bbe2ba65@mail.gmail.com>
	 <20091008173900.GI9261@spearce.org>
	 <fabb9a1e0910081058m59527600o392a6b438b18512e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	vcs-fast-import-devs@lists.launchpad.net, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 13:42:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwwom-0001AJ-2s
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 13:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760390AbZJKLlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Oct 2009 07:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760203AbZJKLlG
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 07:41:06 -0400
Received: from mail-yw0-f176.google.com ([209.85.211.176]:55926 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760183AbZJKLlF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Oct 2009 07:41:05 -0400
Received: by ywh6 with SMTP id 6so7440159ywh.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 04:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=S9Gs1XLYNmVfdms2eiUg6b3WG6TZWrQcBpj7hPV8SOA=;
        b=Kvsv4JqZ02veL1Esdg/BLVvoqdAZ398FNIDhz7b6XXoAbb+xxSGU9xDP9ssGt1pMGT
         lb7pa6MnJTQ73zEtjmTjdCfJnCjudLc7Yb+82IrK8UuKHv6uhTyoyWg9oRro0jI+D/4Z
         4Z8codWaMOqPaiqPCT+oAfPfmpXSTWSV2czqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=DEKgZVzAYB28UqtH54IjDqSToJsCfqj3PGOEl6PqoJ8qDYPCfGSI9IWY/Y1lg2xJr8
         NkLcZGgXSj9NwXeQIvIbSPhXhViBK1rvPChj6dtvT68NTVkeYSUx8SdNrKTXILbhi9EH
         XffN8X08axbSuW/trESPZSzulaeNh2zBAbbQo=
Received: by 10.150.141.15 with SMTP id o15mr8093710ybd.86.1255261228007; Sun, 
	11 Oct 2009 04:40:28 -0700 (PDT)
In-Reply-To: <fabb9a1e0910081058m59527600o392a6b438b18512e@mail.gmail.com>
X-Google-Sender-Auth: cc7df90c47a4620f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129916>

On Thu, Oct 8, 2009 at 1:58 PM, Sverre Rabbelier <srabbelier@gmail.com>=
 wrote:
> On Thu, Oct 8, 2009 at 19:39, Shawn O. Pearce <spearce@spearce.org> w=
rote:
>> Other options that are clearly git should be declared as:
>>
>> =A0option git max-pack-size=3D2048
>>
>> with the meaning of option being declared something like:
>>
>> =A0If the parsing VCS name appears as the first argument, the parsin=
g
>> =A0VCS must recognize and support the supplied option, and if not
>> =A0recognized or not supported must abort parsing altogether.
>>
>> =A0If the parsing VCS name is not the first argument, it must entire=
ly
>> =A0ignore the option command and not try to process its contents.
>
> I think it makes to ignore options that are not for our vcs, as long
> as options that change import behavior (such as marks, date-format)
> are combined with, say, 'feature tool=3Dgit'. This way we can be sure
> that when outputting out a vcs specific stream, it is only parsed by
> that vcs.

I prefer option-scope VCS specifiers over stream-scope specifiers.
The latter would artificially reduce interoperability between VCSs.
Who is the fast-output developer to say that only one fast-import tool
should use his stream?

--=20
Matt
http://www.google.com/profiles/matthewlmcclure
