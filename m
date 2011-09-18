From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [RFC] fast-import: note deletion command
Date: Mon, 19 Sep 2011 02:59:56 +0600
Message-ID: <CA+gfSn9CsL4tz30B62mDzALdyy1RTFiRT4a1zdJ8pR8aTdcpXA@mail.gmail.com>
References: <CA+gfSn9sdTzQghqQp6hcO-9kN9mPx2JLRig79Rgx2FqGWXXp=A@mail.gmail.com>
	<20110918203506.GG2308@elie>
	<CAGdFq_hpA95Kj4eMr4e1duuXTpr+OkkwF4K5bTapXEi9UjWcSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:00:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5OTJ-0001rW-38
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413Ab1IRU76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Sep 2011 16:59:58 -0400
Received: from mail-qw0-f42.google.com ([209.85.216.42]:45459 "EHLO
	mail-qw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416Ab1IRU75 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2011 16:59:57 -0400
Received: by qwi4 with SMTP id 4so12751157qwi.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=TbVJXgBcYWl6V+fk1LM1H+iD0Vs8uF6Q/oV45MyJBF8=;
        b=QKyQtopkFFgoNFz59o1uyB46ZyQR2/nMdnFFmXVO1GDI5HnV8XCX7uhAoHsJe9zQm7
         Xu+2Jsyf2woRHReeeTRSKUasVcSvKAsp4q+8sMWyu/VBPizp0nNGOtiEywsSx8hUgNmO
         KGc69It0ZGR0jCVVkELi2A9jrehO3u3Y8mjOg=
Received: by 10.229.10.200 with SMTP id q8mr752066qcq.244.1316379596553; Sun,
 18 Sep 2011 13:59:56 -0700 (PDT)
Received: by 10.229.224.17 with HTTP; Sun, 18 Sep 2011 13:59:56 -0700 (PDT)
In-Reply-To: <CAGdFq_hpA95Kj4eMr4e1duuXTpr+OkkwF4K5bTapXEi9UjWcSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181637>

On Mon, Sep 19, 2011 at 2:39 AM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> Heya,
>
>>
>> If I were doing it:
>>
>> =A0- advertise "N 0{40} <commit>" as the historical way to delete a
>> =A0 note, and make sure it keeps working
>>
>> =A0- introduce 'ND' or 'notedelete <commit>' as a human-friendly
>> =A0 synonym, keeping in mind that NC and NR could be introduced in t=
he
>> =A0 future if there is demand for them.
>
> Is this perhaps a good moment to also think about branch deletion?
> That came up earlier as well, and thinking about that might give us
> some insights in how to deal with deletions uniformly.
Also maybe marks deletion, getting mark sha1,  resetting a mark with
explicit sha1. But most probably not tags deletion.

And going much further on commands, following look nice to have:
- 'ls' storing result to a mark (to allow us not to compute sha1/store
  object if we don't want to)
- marks namespaces (to keep ls mark separately, mark deletion will
  do too, if it's only a single temporary mark). Maybe like ::nr:mark.

>
> --
> Cheers,
>
> Sverre Rabbelier
>
