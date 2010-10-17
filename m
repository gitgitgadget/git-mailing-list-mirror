From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCHv2 1/5] worktree: provide better prefix to go back
 to original cwd
Date: Sat, 16 Oct 2010 19:48:02 -0700
Message-ID: <4CBA63E2.8030502@gmail.com>
References: <1287185204-843-1-git-send-email-judge.packham@gmail.com> <1287185204-843-2-git-send-email-judge.packham@gmail.com> <20101016184259.GB30457@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, pclouds@gmail.com,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 04:47:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7JHi-0001Yi-RY
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 04:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259Ab0JQCrh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Oct 2010 22:47:37 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58178 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757228Ab0JQCrh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 22:47:37 -0400
Received: by pva18 with SMTP id 18so155623pva.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 19:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PqGk4D4IdfKrUJMRkrFhPqPUqxZNigutiacmTHb4gp0=;
        b=kRtoWQnIr5Bx7wr/Grdx7yCWkoyt5wKgKkSOkJiR4FAlSXrz6TWLl1JHR4HiECuWio
         lih+vyW7us1Rb5FGCt97l7sHEp5WG5nYOxPpSVDssexMGbAbqztlpBK0VG7AF6rIsmIJ
         Nc48/HLC2qj9vHG3CMOSneN92CkxPXe6mYdBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=sIs6sRecKz8ukz8jKMWQu4arVAnRHpLFDlCcTP+3cAcCMzb9g7AFwvI8xrAjP0ElQX
         wLPLlcYCYl+sEL4Qjh7rUBXbMe8J0e7sDd2Ki2DUXw60god1yVeIcQijCOd9O4HK0pHX
         3NnJKF5CCF1eUVQQC4nFsqX5p80KunO3/pbPo=
Received: by 10.142.156.12 with SMTP id d12mr2143572wfe.139.1287283655199;
        Sat, 16 Oct 2010 19:47:35 -0700 (PDT)
Received: from laptop.site (adsl-71-131-194-2.dsl.sntc01.pacbell.net [71.131.194.2])
        by mx.google.com with ESMTPS id e14sm13050997wfg.20.2010.10.16.19.47.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 19:47:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.12) Gecko/20100914 SUSE/3.0.8 Thunderbird/3.0.8
In-Reply-To: <20101016184259.GB30457@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159189>

On 16/10/10 11:42, Jonathan Nieder wrote:
> Hi,
>=20
> Chris Packham wrote:
>=20
>> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>>
>> When both GIT_DIR and GIT_WORK_TREE are set, if cwd is outside workt=
ree,
>> prefix (the one passed to every builtin commands) will be set to NUL=
L,
>> which means "user stays at worktree topdir".
>>
>> As a consequence, command line arguments are supposed to be relative
>> to worktree topdir, not current working directory. Not very intuitiv=
e.
>=20
> Thanks.  More detailed history for this patch:
>=20
>  - v0: http://thread.gmane.org/gmane.comp.version-control.git/157599/=
focus=3D157601
>  - v1: http://thread.gmane.org/gmane.comp.version-control.git/158287
>  - v2: http://thread.gmane.org/gmane.comp.version-control.git/158369
>=20

I think I must have missed v2. I was playing around with my gmail
filters around that time so I could have missed them. Actually now I've
found the message it's missing the last 'm' in gmail.com. I'll grab the
latest patch and give it a test when I get a chance.

> Any thoughts about the previous questions?
>=20

I haven't caught up on the newest thread so no great revelations. Excep=
t
that for the grep submodules use-case we can assume that the worktree
will be a subdirectory of the cwd. I don't think we want to limit
ourselves to that one use-case.
