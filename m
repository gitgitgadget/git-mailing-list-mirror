From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4018: introduce test cases for the internal hunk header
 patterns
Date: Mon, 19 Dec 2011 15:17:55 -0800
Message-ID: <7vmxaokv6k.fsf@alter.siamese.dyndns.org>
References: <20111217012118.GB20225@sigill.intra.peff.net>
 <31E9klcRboMV0wSJY5WO-N7nIBOUOa_wr6MVfWY9AInImxJIqC0flahvpDrVGMIuZ9e7Ouha1HDuesbwTGaNQA4dgN-FShNJKkfMG_cHLUJAT2rE539shnQxzM0dQyZIb5661As6Tvs@cipher.nrlssc.navy.mil> <7vty4wkx19.fsf@alter.siamese.dyndns.org> <CA+sFfMeogJ==ud6NdPj_KZFUKFeB--RBmPkLndjrQwhg15V5ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, peff@peff.net,
	git@vger.kernel.org, j6t@kdbg.org, jrnieder@gmail.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 00:18:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcmT6-0003af-2i
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 00:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab1LSXSA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Dec 2011 18:18:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48930 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779Ab1LSXR6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2011 18:17:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E30077B42;
	Mon, 19 Dec 2011 18:17:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XHOau7O+mOqF
	b+0JWbXxzoaIQi8=; b=F70UhZH6BPMmvpI0aeP5LOEYTKsLZIX7E9bQ5hytHPhc
	Vi0769qEgtTSk+TrDkIKhsz2VsOHdQehADOg95xLaMC9dCXGeCX1lL3PUKI/HF7r
	inta+IApxkyPx4oZkTNr3zkoASOt/NVgG995fl5N3ZGld76xasHo8sid52P1baI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IwGgi9
	9cSK6BWvJpJRTT/xWEJbl5LabLji54BZBlSjt9R7JzNmbAoTPvSM6bK5PtAn5TCt
	gson4d6+1BLQUzCMuDLArxS0mS7tG+oTFNi/SJb5JO2/2m6lug5DJxAO4EuxDOx1
	pwi2jF0NX/pWGRmjtKYqedE3RuozseF/n0ks0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9DA27B41;
	Mon, 19 Dec 2011 18:17:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A9A17B3D; Mon, 19 Dec 2011
 18:17:57 -0500 (EST)
In-Reply-To: <CA+sFfMeogJ==ud6NdPj_KZFUKFeB--RBmPkLndjrQwhg15V5ig@mail.gmail.com> (Brandon
 Casey's message of "Mon, 19 Dec 2011 16:57:28 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFA681F6-2A97-11E1-B0BE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187483>

Brandon Casey <drafnel@gmail.com> writes:

>> =C2=A0 =C2=A0* after the line that contains "RIGHT" token, there sho=
uld be one (and
>> =C2=A0 =C2=A0 =C2=A0only one) line that contains "ChangeMe". The tes=
t modifies this
>> =C2=A0 =C2=A0 =C2=A0token to "IWasChanged", compares the original wi=
th the modified
>> =C2=A0 =C2=A0 =C2=A0result, and expects the "RIGHT" token above appe=
ars on the hunk
>> =C2=A0 =C2=A0 =C2=A0header.
>
> Both good improvements.

Let's not call "ChangeMe" a *token*, as I think the easiest example wou=
ld
look like the following and it would not use it as such.  Rephrasing it=
 as
a "string" would be better.

    @@ ... @@ int RIGHT_function_hunk_header(void)

     int RIGHT_function_hunk_header(void)
     {
    -    const char *msg =3D "ChangeME";
    +    const char *msg =3D "IWasChanged";
         printf("Hello, world, %s\n", msg);
	 return 0;
     }
    @@ ...
