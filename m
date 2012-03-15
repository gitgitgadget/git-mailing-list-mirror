From: Chris Kees <cekees@gmail.com>
Subject: Re: --progress for git submodule update?
Date: Wed, 14 Mar 2012 22:43:44 -0500
Message-ID: <CAOVFbFj4nF1GmqdDSmb4z_JXXTxsNktRGaaReF8=msbOwaRt=g@mail.gmail.com>
References: <CAOVFbFiBOH2MyC3HUtf=hA_PssSRENW7uwpBVxh0TwnO7h90XA@mail.gmail.com>
	<4F5D0FFD.1020509@web.de>
	<CAOVFbFhMfpFa5=a0Z50H7nHdQFHn9Y4ApUnQJq6GCOFP+AKy5A@mail.gmail.com>
	<4F60F4A6.1070507@web.de>
	<7vd38eoo0u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 04:43:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S81bT-0000xu-3b
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 04:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183Ab2CODnq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 23:43:46 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:61819 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928Ab2CODnp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2012 23:43:45 -0400
Received: by wejx9 with SMTP id x9so2388081wej.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 20:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3XMvQt7agiiUjvVgq0DE533SJt/QeDlMZ2NGwMa96Cg=;
        b=yGpOfNF6Sa140ZiYqQe566ho86a1FlM+2WW712CbWG1Awhv2OLk9PPa/aUHR6G7kxs
         y++zYwwyiyIKU6BJAVTwMpgQoWtbx/E4ZsPQAXKeq8rcFxd5GmLlvjtBHE/jUAEMsVaA
         XepPMp4fKKa4WEBqirc5PPGUPJ13lLbSZyN7K6GeOYoc3noVoLZIYReVfSUnar8ZdKMf
         0UGRGtGAmGn+yqPrXW4Ke8gZcchGPYGp8g7C/e4ll2SpMAWeVzq8fxCfQt9vI/SyJ4KF
         1WxyQkIAnsXIlcFHMl1BArcdadih9WdnYwGS8mGeJ+LtXgtONbrIpShcjYevNRcxecW9
         ymAw==
Received: by 10.180.102.231 with SMTP id fr7mr11806191wib.10.1331783024238;
 Wed, 14 Mar 2012 20:43:44 -0700 (PDT)
Received: by 10.216.178.8 with HTTP; Wed, 14 Mar 2012 20:43:44 -0700 (PDT)
In-Reply-To: <7vd38eoo0u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193174>

Yes, I meant when they have to be cloned initially. It was actually
the builtbot developers who asked me to post a request because the
lack of output is used to trigger the timeout and the output is
conveniently stored and posted to the web so you can see what is
happening on a given platform. Here is the snippet from the log of a
machine failing because the python submodule of the project is taking
too long--clearly a slow network issue since python generally
shouldn't take more than 20 minutes to clone:

Cloning into externalPackages/clawpack/clawutil...
Submodule path 'externalPackages/clawpack/clawutil': checked out
'48f6be675b6fe40be62c39a48e1c948903e5c43d'
Cloning into externalPackages/clawpack/pyclaw...
Submodule path 'externalPackages/clawpack/pyclaw': checked out
'921b1796b9bb0d11db1ced7996f95b9b24ce0b23'
Cloning into externalPackages/clawpack/riemann...
Submodule path 'externalPackages/clawpack/riemann': checked out
'a16d64d750fc414ce131455734ae7d68d6c0f46b'
Cloning into externalPackages/clawpack/visclaw...
Submodule path 'externalPackages/clawpack/visclaw': checked out
'2b6ab68330c4498eade4b2e7dabc5de9b593ecac'
Cloning into externalPackages/cython...
Submodule path 'externalPackages/cython': checked out
'77fd4991fe270b1097318c8ccdca9740df68d9e6'
Cloning into externalPackages/daetk...
Submodule path 'externalPackages/daetk': checked out
'781f732fbc206cfdfa6da170fbc161a80d4133f8'
Cloning into externalPackages/hdf5...
Submodule path 'externalPackages/hdf5': checked out
'e853fa711d4ecc71ba7025c64db5bbe41558d635'
Cloning into externalPackages/ipython...
Submodule path 'externalPackages/ipython': checked out
'698e9abebe0d6e0f261e7050c48680c4608a0985'
Cloning into externalPackages/matplotlib...
Submodule path 'externalPackages/matplotlib': checked out
'd6ec786c28b9ddbcb0704a1a6e1fb7233eb3212b'
Cloning into externalPackages/mpi4py...
Submodule path 'externalPackages/mpi4py': checked out
'eac3d3602e8272ab8eff46988fde396f0a255d90'
Cloning into externalPackages/nose...
Submodule path 'externalPackages/nose': checked out
'ccb3878af99138301c612d5bb92e7a27d3e39d22'
Cloning into externalPackages/numexpr...
Submodule path 'externalPackages/numexpr': checked out
'ed3ca13b58548d68fbc8b9a380990aac1e4897c9'
Cloning into externalPackages/numpy...
Submodule path 'externalPackages/numpy': checked out
'3f685a1a990f7b6e5149c80b52436fb4207e49f5'
Cloning into externalPackages/petsc...
Submodule path 'externalPackages/petsc': checked out
'4d5fdb033efc8bf2cdfe228f993ec9305f98854b'
Cloning into externalPackages/petsc-BuildSystem...
Submodule path 'externalPackages/petsc-BuildSystem': checked out
'e9f7e22d13f5d12da05c8f5d34d574e4bfe053ff'
Cloning into externalPackages/petsc4py...
Submodule path 'externalPackages/petsc4py': checked out
'adae544de17fd8cdcf2d51290ddaecfbe2107180'
Cloning into externalPackages/pytables...
Submodule path 'externalPackages/pytables': checked out
'467ba035ba72acd7df28c648b1a52ecadebe4935'
Cloning into externalPackages/python...

command timed out: 1200 seconds without output, attempting to kill
process killed by signal 9
program finished with exit code -1
elapsedTime=3D2641.623387


On Wed, Mar 14, 2012 at 4:45 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> Am 13.03.2012 03:17, schrieb Chris Kees:
>>> It's 'git submodule update --recursive' that is taking so long
>>> silently. =A0The problem is mainly on the first time. There are abo=
ut 10
>>> submodules that together have taken more than 30 minutes. It's not
>>> really just the amount of data, I think there are also network traf=
fic
>>> issues that slow things down on some systems.
>>
>> I suppose with "first time" you mean right after "git submodule init=
",
>> when the submodules have to be cloned initially? Thinking about that
>> again, you mentioned a buildbot doing all that. When the submodules
>> are updated from a script, no progress output is shown at all and on=
ly
>> the line "Cloning into 'xxx'..." will appear for each submodule, whi=
ch
>> explains why you don't see output for quite some time.
>>
>> So I suspect increasing the timeout on your buildbot is the way to g=
o,
>> as progress output is intended for humans.
>
> Considering that more often than not, people who run stuff from cronj=
ob
> request us to be quiet when nothing wrong happens, I think that is a
> sane thing to suggest.
>
> I do not mind "submodule $subcmd --progress" to pass "--progress" dow=
n to
> whatever underlying git commands it uses, or squelch "-q" that it use=
s
> when running them by default, though.
>
> We may even want to make "git submodule init -q" to squelch the "Clon=
ing
> into..." message, but that is a separate topic.
>
