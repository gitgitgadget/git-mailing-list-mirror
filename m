From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] builtin/merge_recursive.c: Add a usage string and make
 use of it.
Date: Sun, 29 Aug 2010 19:24:31 -0300
Message-ID: <AANLkTimopOKiq1ef1YvbR28ArcEZ4nV+P_-DcfSKsJyO@mail.gmail.com>
References: <c9d88eb8cbd5b025b0c0112be05d3c0fe993de25.1283103426.git.tfransosi@gmail.com>
	<20100829214648.GE1890@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 00:24:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpqIn-0001cm-Fy
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 00:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab0H2WYd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 18:24:33 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34105 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618Ab0H2WYc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 18:24:32 -0400
Received: by qyk33 with SMTP id 33so4641753qyk.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 15:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qOFIfJUuCW0vS9mHKA6btpqSabdmxSFLPraz5ef0+W4=;
        b=MeLv6ozVIMyFseL2eVLiA1qCv7UlFevXs7qU6aC1dFb4atY9dgvjhUVLOwx0oqR2J0
         +MsiUd4zWlSVncD5FzTTaso6kX780Q3+s+FW42jBaQSSWnUle3YlUu3U0ZTqdDmA4x83
         UNk9Tub85+mx7mmE0Wmk55xUx4kzJ8L9+tnsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fVygfFpDypicZ/f/ISrYh3T7yCjH6y4vdsfIkMWalEDxnGL+HrrTCa9HSavLu/Mk3+
         O5VbM3+GLmsWzUBRgeJhGy04evAZFmW1RZw0j0ziMz0+25tNwuaT6qg6m5yfhaY+Clk0
         KaunqWCpaxS1X98ioqMstVKbcCGpJE1Vj+2jc=
Received: by 10.224.124.80 with SMTP id t16mr2284054qar.204.1283120671340;
 Sun, 29 Aug 2010 15:24:31 -0700 (PDT)
Received: by 10.229.245.202 with HTTP; Sun, 29 Aug 2010 15:24:31 -0700 (PDT)
In-Reply-To: <20100829214648.GE1890@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154728>

On Sun, Aug 29, 2010 at 6:46 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi Thiago,
>
> Thiago Farina wrote:
>
>> This improves the usage output by adding builtin_merge_recursive_usa=
ge string
>> that follows the same pattern used by the other builtin commands.
>>
>> Also it uses usage() function instead of the usagef() function.
>
> FWIW cmd_merge_recursive is used to handle four different commands.
>
> $ git grep -F -e cmd_merge_recursive
> builtin.h:extern int cmd_merge_recursive(int argc, const char **argv,=
 const char *prefix);
> builtin/merge-recursive.c:int cmd_merge_recursive(int argc, const cha=
r **argv, const char *prefix)
> git.c: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ "merge-recursive", cmd_mer=
ge_recursive, RUN_SETUP | NEED_WORK_TREE },
> git.c: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ "merge-recursive-ours", cm=
d_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
> git.c: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ "merge-recursive-theirs", =
cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
> git.c: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ "merge-subtree", cmd_merge=
_recursive, RUN_SETUP | NEED_WORK_TREE },
>
> What will be the output from
>
> =C2=A0$ git merge-subtree -h
>
Thanks for catching this, fixed in the v2 patch.
