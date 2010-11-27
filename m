From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] commit: Append commit_list prefix in two function names.
Date: Fri, 26 Nov 2010 23:54:05 -0200
Message-ID: <AANLkTi=V7e-KFhKVDLjH4TvoT6U3xmFieo5uqigPhqKF@mail.gmail.com>
References: <0b9cde68dcdfddc13a91a63f9deb3384576164de.1289768501.git.tfransosi@gmail.com>
	<20101114211905.GB10150@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 02:59:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMA4B-0007kI-PL
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 02:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399Ab0K0ByJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 20:54:09 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64153 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278Ab0K0ByH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Nov 2010 20:54:07 -0500
Received: by bwz15 with SMTP id 15so2310419bwz.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 17:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fodVtFz886R7mRTV7zDawdgaZ6qoQrxo3FGNmbk8hwk=;
        b=MRR12NmRIAWCW75hFdqtYINg6liExAp69eidP4ejewMtE8vSVg4MQBvZPqWy8jIlxL
         jaUZFn2flIWVFMOFkzTZ4q2NFyOvIivw7okzHzOtf5HTvHlaxcTtR6fgJulKnAWwVN4K
         iQP01EyC1r5hSlg4lZXEOfuwP1fu0UXOFbS6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ia2ekQTX0JNMz6M2QXrFpuo5WTiErp3Q1CtebJ/njSsOfYuEsOhGVJ4SKCN9qXUJS+
         7H5PU7W51LwfPAy4b4in8Pilnpr5fXOFuprjmDxSuJTZ/Gz9+Ce/9S9FoyAqWhAGRVO0
         ptrPSycNHcr+D93h8+XTWYr8l7t6+zHFfSock=
Received: by 10.204.62.17 with SMTP id v17mr2549774bkh.67.1290822845938; Fri,
 26 Nov 2010 17:54:05 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Fri, 26 Nov 2010 17:54:05 -0800 (PST)
In-Reply-To: <20101114211905.GB10150@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162292>

On Sun, Nov 14, 2010 at 7:19 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Thiago Farina wrote:
>
>> Append commit_lis prefix to insert_by_date function and to sort_by_d=
ate,
>> so it's clear that these functions refer to commit_list structure.
>
> Nits: by "Append" I think you mean "Add"; missing "t" after commit_li=
s.
>
Thanks, I will fix this in a follow up.

> This gives the oft-used insert_by_name() function a fairly long name:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit_list_insert_by_name
>
> The proposed name is long enough to be unwieldly. =C2=A0It might have
> the virtue of fitting better with some of the commit_list lib:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit_list_count
> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit_list_insert
> =C2=A0 =C2=A0 =C2=A0 =C2=A0free_commit_list
>
> Compare:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sort_by_date
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pop_most_recent_commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sort_in_topological_order
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pop_commit
>

I don't understand what you are arguing here. Is about the size of
"commit_list_insert_by_name"? I don't care about it's size, I just
want to make it consistent by adding commit_list in the functions that
are part of the commit_list API.

> Perhaps this change would work better if some of the others were
> renamed at the same time?
>

I don't think so, this would increasing the size of the change and
make it less readable.
