From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 3/3] builtin-merge: add support for default merge options
Date: Fri, 6 Mar 2009 18:16:08 -0500
Message-ID: <76718490903061516l62869424q4bd4cfa64fe2195e@mail.gmail.com>
References: <cover.1236377358.git.jaysoffian@gmail.com>
	 <12addb53ef5c0e62ee22847591c8e7b884dc0bd2.1236377358.git.jaysoffian@gmail.com>
	 <13f0016028b195541b8b5d9149292150cbb13ab7.1236377358.git.jaysoffian@gmail.com>
	 <9f755b5bae0b02c5cb3e01680acf71fe7153be04.1236377358.git.jaysoffian@gmail.com>
	 <7vr61aqngu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jean-luc malet <jeanluc.malet@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 00:17:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfjIT-0001aJ-Lg
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 00:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbZCFXQM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 18:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbZCFXQM
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 18:16:12 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:41103 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbZCFXQL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 18:16:11 -0500
Received: by rv-out-0506.google.com with SMTP id g37so715522rvb.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 15:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tkzuAL3saBAaaCGv68bZy2oVlqs05PgEJ1cvti4pr1s=;
        b=wALBJv0fexBSHPtG8WthmLlBWHO+a3ysk+qPWgArjcUL6MSc6RtJCY9fUrsVld6lbK
         GuQ23roMdOyyxSv5M8ULfZMfcy1iMPQUZhBhfCueM2SknwAhC8RkrWqz/gmQ8VgakSyN
         9cI4fVSXnbJpPtnbzhfj4mviNADk9D4EOPNcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=puqr37y7KYIFxg2VfduUrft8sWEpCWsvnh0vxo59iMmSUd2IER5yiDeD5wjMkjfATq
         2FeoTFg9/gPtkx6qjzkEMjUYaJ4BB2EOBliWbGaEhNl/pZW9Lb966wSI8PcFu97iErTM
         /+QuUIYmi/SM/mQnFio/Wa7WUXUP0iE1s9rXw=
Received: by 10.140.250.14 with SMTP id x14mr1536123rvh.79.1236381368045; Fri, 
	06 Mar 2009 15:16:08 -0800 (PST)
In-Reply-To: <7vr61aqngu.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112492>

On Fri, Mar 6, 2009 at 5:46 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:

> When you are on branch "frotz", your config have both merge.options a=
nd
> branch.frotz.mergeoptions, and you give some other options from the
> command line, how should they interact? =C2=A0I'd expect the branch.*=
=2Eoptions
> to take effect, ignoring merge.options entirely.

Really? I didn't think that would be consistent with the fact that the
the command line options override branch.*.options, but don't replace
them. So I specifically coded it such that there are three separate
layers all merged together. (Which is also how I documented it in the
man page.)

> If for some reason you would want to have cumulative options across

Which I do, or I wouldn't have coded it that way. :-)

> branch.*.merge, merge.options and the command line, then you would in=
stead
> keep two separate strings, and call git_config_option_string() for bo=
th of
> them, before processing the real command line options.

Ah, right that would be better.

j.
