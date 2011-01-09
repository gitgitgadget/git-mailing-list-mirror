From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Sun, 9 Jan 2011 13:55:04 +0000
Message-ID: <AANLkTinwb8orMBjcQjK0ogXd6rMEtRwT8SV41k8D3AXL@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
	<alpine.LFD.2.00.1101061956470.22191@xanadu.home>
	<AANLkTikKn1+2OX1KPy+9US_yX=E6+CiaCTTB6yqnAWwW@mail.gmail.com>
	<AANLkTimgn2_BWYjbGKbGoeGJ=erKundX4umfy=s16dB1@mail.gmail.com>
	<AANLkTim2A4=y=XcuPuPiYGDGZyKAUEk-yv2cZVEGhQ3C@mail.gmail.com>
	<AANLkTi=KPVMEviQhyJeWHynPa2q6NJpQ2VyAhbRcmQ1D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 09 14:55:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pbvk2-0004ZJ-3w
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 14:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793Ab1AINzU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jan 2011 08:55:20 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48860 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab1AINzG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jan 2011 08:55:06 -0500
Received: by vws16 with SMTP id 16so7836125vws.19
        for <git@vger.kernel.org>; Sun, 09 Jan 2011 05:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P+tT2MxO1I2R+6teilh6ikZYiJjaBL9Q2KZnS/pZs+o=;
        b=nhu7CGATHL6evIZPDe3fxhjkgnWTaGfFcbkmgcTXkaGmhsJQxgS7osCC8uOksZQdhe
         fVPEBQiEZfC5sn6W+6jnjLXmqxwaoKSNlBehRcNqJMSEt6Ls7La5XWKzM5fqo8ilkZuK
         AVebL7xERE6hCatDs1lgSBv3pKLLbac5rIluw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tZANzWu1sb/EPW3nHOpGO4Ry8Xq48YtdnToZ/qH/5s7OKjYawPPJcW8vWiAOXnfC/h
         8joluzxVviOcFfrWtvh6HlvscnUr89hc9NF41eBasFuwVltb1k8U8hHVqhgpSO2hwhGE
         01JBpawK23DDlhcLpRR54a5ia/rSYP2duMaTM=
Received: by 10.220.178.77 with SMTP id bl13mr8941852vcb.42.1294581304778;
 Sun, 09 Jan 2011 05:55:04 -0800 (PST)
Received: by 10.220.190.203 with HTTP; Sun, 9 Jan 2011 05:55:04 -0800 (PST)
In-Reply-To: <AANLkTi=KPVMEviQhyJeWHynPa2q6NJpQ2VyAhbRcmQ1D@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164850>

On Sun, Jan 9, 2011 at 3:34 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> On Sun, Jan 9, 2011 at 12:21 AM, Luke Kenneth Casson Leighton
> <luke.leighton@gmail.com> wrote:
>> =C2=A0ok - you haven't answered the question: are the chains perfect=
ly
>> fixed identical sizes?
>
> No.
>
>> =C2=A0if so they can be slotted into the bittorrent protocol by simp=
ly
>> pre-selecting the size to match. =C2=A0with the downside that if the=
re are
>> a million such "chains" you now pretty much overwhelm the peers with
>> the amount of processing, network traffic and memory requirements to
>> maintain the "pieces" map.
>
> No, there are thousands of them only (less than 100k for repos I
> examined). It's precisely the reason I stay away from commits as
> pieces because commits can potentially go up to millions.

 ok - thousands is still a lot.  i recommend that you examine:

 * the heuristics algorithm in bittorrent for piece-selection
 * large repositories such as webkit (1.2gb) and the linux kernel (600m=
b)

 you still have to come up with a mapping from "chains" to "pieces".
in the bittorrent protocol the mapping is done *entirely* implicitly
and algorithmically.  the "meta" info in the .torrent contains
filenames and file lengths.  stack the files one after the other in a
big long data block, get a chopper and just go "whack, whack, whack"
at regular piece-long points, that's your "pieces".  so, reassembly is
a complete bitch, and picking just _one_ file to download rather than
the whole lot becomes a total pain.

why the bloody hell the bittorrent protocol doesn't just have a file
id i _really_ don't know, it would have made things a damn sight
easier.  anyway - if you're going to modify and "be inspired by" the
bittorrent protocol, you really should look at adding some sort of
"chain" identification - f*** the "chains"-to-"pieces" algorithm, just
add a unique chain id to the relevant bittorrent[-like] command.


>> =C2=A0if not then you now need to modify the bittorrent protocol to =
cope
>> with variable-length block sizes: the protocol only allows for the
>> last block to be of variable-length.
>
> Ah I see. I do not reuse bittorrent code out there. Just its ideas,
> adapted to git model.

 that's hard work and you're now into "unproven" territory.  the
successful R&D proof-of-concept code that i wrote i _deliberately_
stayed away from "adapting" a proven bittorrent protocol, and as a
result managed to get that proof-of-concept up and running within ...
i think it was... 3 days.  most of the time was spent arseing about
adding in a VFS layer into bittornado, in order to libratise it.

i mention that just to give you something to think about.  if you're
up to the challenge of writing your own p2p protocol, however, GREAT!
you'll become a world expert on _both_ peer-to-peer protocols _and_
git :)

 l.
