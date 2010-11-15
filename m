From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] Makefile: move "Platform specific tweaks" above
 LIB_{H,OBJS}
Date: Mon, 15 Nov 2010 10:11:22 -0600
Message-ID: <20101115161122.GB16385@burratino>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
 <1289745857-16704-2-git-send-email-avarab@gmail.com>
 <20101114172331.GA26459@burratino>
 <AANLkTinaDhXQjPC6s1eFb8HwEReW7P-ObmwRn2Hpb=O4@mail.gmail.com>
 <20101114185130.GA18385@burratino>
 <7v8w0umuz7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 17:12:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI1f3-0004Cs-RD
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 17:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757052Ab0KOQMA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 11:12:00 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:65174 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757863Ab0KOQL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 11:11:59 -0500
Received: by qwj8 with SMTP id 8so202657qwj.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 08:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/dNZaBXnTdQqcmxSNGAqCZiRUmkFw4vUCXDhFrBgbrc=;
        b=qTL1YFJdCojhPDdNlfVDK8wLUEPJmU9EiBJe6OdrawLctsxaw7DMUYYWI76206tdBl
         j0yfNW963P9s2LmgaBneTOXepSKfRPw1PQtGS9jJGZMFrivCg0QWbvbQry/x6JSi76hm
         jI09fn1CRGcfBlwal0bujrGNBXc6F2D3OvN48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CbKErg+M2CRnazH/Ynh8C7GYWKUNw/miNF/vYWinGPT0Cs+lIqkpF5yPeILmnr0sRr
         RQqJcNoqkEJNgUsoNo3qSAmta7UWsTcULZkDeN+ZdoB6FFHFPAak8y4agC2iqVxF8fms
         qPMhz2PX+HqBuQC4nF4qewPzwDIQacEK/UbAs=
Received: by 10.229.91.211 with SMTP id o19mr5405581qcm.87.1289837519158;
        Mon, 15 Nov 2010 08:11:59 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n7sm70140qcu.40.2010.11.15.08.11.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 08:11:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v8w0umuz7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161493>

On Mon, Nov 15, 2010 at 08:07:08AM -0800, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>>> That listing should be in a comment at the start of the
>>> Makefile. Please submit a patch for that!
>>
>> How about this?  An annoying piece of GNU makefile syntax makes this
>> uglier than it needs to be (search for HACK for details).
>>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>> diff --git a/Makefile b/Makefile
>> index 1f1ce04..38edd65 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1,6 +1,8 @@
>>  # The default target of this Makefile is...
>>  all::
>> =20
>> +outline:: ; @echo "Configuration."
>> +
>>  # Define V=3D1 to have a more verbose compile.
>>  #
>>  # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
>
> Hmm, I don't quite get what you are trying to do here.  What good doe=
s the
> output from "make outline" do to a potential/actual developer?  You c=
an
> learn that there are sections for "Testing rules", but then what?  Yo=
u
> will look for that string in the editor or pager.

I dunno.  I wrote it because =C3=86var asked for it (and to make visibl=
e
where the trivial obstacles would lie in getting target-listing "make h=
elp"
to work, which is more interesting to me).
