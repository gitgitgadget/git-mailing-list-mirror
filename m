From: Paul Richards <paul.richards@gmail.com>
Subject: Re: Enumerating all objects in the Git object store
Date: Fri, 26 Mar 2010 21:11:07 +0000
Message-ID: <a1138db31003261411o136145eeu14afe75ee3d170f5@mail.gmail.com>
References: <a1138db31003260831q34967f69u9fc8de861f7931b1@mail.gmail.com>
	 <4BACD86E.4020803@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 22:11:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvGoG-00088t-2E
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 22:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab0CZVLK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 17:11:10 -0400
Received: from mail-ew0-f221.google.com ([209.85.219.221]:50631 "EHLO
	mail-ew0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847Ab0CZVLJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 17:11:09 -0400
Received: by ewy21 with SMTP id 21so2292873ewy.25
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=PhmE3Agtl5ExJKjrIharK6NZygVYv8jolAeV5CcwmUs=;
        b=vsMbszLiB15mRQP2DoV1Uu8kNqG0ZGBhui9wa6QzmmEiqAOGY1usvqJbDaR4kFaWD0
         8d0yUQImhm0z/sXdKHqlkPJvq0m6QDDCDvuLQzWYQtJ736geIjhWrE1w4zXbrUYbFqz3
         j+M+TMRG9314ueSSWMCMP1PnqJDeF/PKezhz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=UdF+xX+//3mVNQH/KCv5j/XjFpdwRXEAj0nSAamZs4ItPy2h5+MJ/DDp6E+rYcneTy
         EChFz89yuRt4UwYg4cJos1B4/oUlSSwEwLMOcCDK5TxiScMpeiTVDFGu1rqamQ+7JYYG
         49A+95hketWsIbxCYbOXD3esslcCvdqk1NoaU=
Received: by 10.213.17.68 with HTTP; Fri, 26 Mar 2010 14:11:07 -0700 (PDT)
In-Reply-To: <4BACD86E.4020803@viscovery.net>
Received: by 10.213.42.15 with SMTP id q15mr892170ebe.35.1269637867392; Fri, 
	26 Mar 2010 14:11:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143286>

On 26 March 2010 15:53, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 3/26/2010 16:31, schrieb Paul Richards:
>> Is there a way to enumerate all the objects in the Git
>> object store, and for each one figure out its type (commit, tree, or
>> blob) and obtain a list of the objects it references? =C2=A0If not, =
is
>> there a way to do this for a single object at a time? =C2=A0(I can t=
hen
>> simply recurse through the whole structure.)
>
> Use 'git rev-list --objects --all' to find all objects connected to a=
ll
> refs (use something else than --all if you want to). Do *not* look at=
 the
> path that the tree and blob objects have attached - it is not authora=
tive
> information.
>
> Use 'git cat-file -t' to find the type.
>
> Use 'git cat-file -p' to pretty-print the content of an object. Parse=
 it
> depending on the type that you find.
>

Thank you, this looks perfect!

I'll check this out (and perhaps the optimizations suggested by Jakub
if necessary).


--=20
Paul Richards
