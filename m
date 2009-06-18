From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: RFH: Unable to get one big pack
Date: Thu, 18 Jun 2009 18:13:35 +0100
Message-ID: <e5bfff550906181013o7c5140bes187e2062126075d9@mail.gmail.com>
References: <e5bfff550906180755i774576c1o1c540224cea675ca@mail.gmail.com>
	 <81b0412b0906180840y62d5c382ha47aebcda3e610f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 19:13:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHLBK-0007X4-IV
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 19:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbZFRRNg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2009 13:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbZFRRNf
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 13:13:35 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:51160 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbZFRRNf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 13:13:35 -0400
Received: by bwz9 with SMTP id 9so1243253bwz.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MWiAgEFR4Okj4Y1zrwHsLosbRTfgOTVcd5NSje8K7fE=;
        b=kRvKWO32fZkRlA+PWtiOSP/I0epCGgX6eNXemkUVZnz2vfKxlou41eh2lbbKLM4W+U
         biMHkYmkkCFABq/sos7isXwJvzrtyWGdlH+bLnZ55gPiCi7fBXzDLCcUOEc/2Faj4TVr
         DgJI9m4C4+RnWI0wX2VdGyqdtOrItBCfLQ6wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nCf/Kv1tiGsLO+fhcreOUl+Z88GIfBghd2jQGPK1IbBqguimxU+N6y+/zz4mij/zPF
         gXwVgcAJ7iRncHcFLLfMqPTFOn+IwwbHGvK7KJED4vNcA2Cg5pZY6xGdbHp/soGk0U89
         BvboSTQCk1JDF0jSJ45TbXLlwDX2PLNgqs5rY=
Received: by 10.216.28.207 with SMTP id g57mr488157wea.163.1245345215758; Thu, 
	18 Jun 2009 10:13:35 -0700 (PDT)
In-Reply-To: <81b0412b0906180840y62d5c382ha47aebcda3e610f1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121857>

On Thu, Jun 18, 2009 at 16:40, Alex Riesen<raa.lkml@gmail.com> wrote:
> 2009/6/18 Marco Costalba <mcostalba@gmail.com>:
>> Sorry for the silly question, but I have tried anything to get one b=
ig
>> pack instead of many objects.
>>
>> I tried git repack but with no success:
>>
>> $ git repack -adf
>> Counting objects: 3317, done.
>> Compressing objects: 100% (3317/3317), done.
>> Writing objects: 100% (3317/3317), done.
>> Total 3317 (delta 2607), reused 0 (delta 0)
>> $ ls -R .git/objects | wc -l
>> =C2=A0519
>> $
>
> git gc && git prune
>

Thanks to you and Nicolas for the hint. It worked.

If I can make a suggestion: description of git-repack is a bit misleadi=
ng

"git-repack(1)

This script is used to combine all objects that do not currently
reside in a "pack", into a pack. It can also be used to re-organize
existing packs into a single, more efficient pack."
