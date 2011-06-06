From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document the underlying protocol used by shallow
 repositories and --depth commands.
Date: Mon, 06 Jun 2011 11:21:09 -0700
Message-ID: <7vvcwi95yi.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=SVZPebW2YXRnaLvkxEDGy_rrtJ3jayt8Oco6Sn8hciQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, schacon@gmail.com, Johannes.Schindelin@gmx.de
To: Alexander Neronskiy <zakmagnus@google.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 20:21:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTeQa-0002La-NF
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 20:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757334Ab1FFSVX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2011 14:21:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932Ab1FFSVW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 14:21:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A6EF4A7F;
	Mon,  6 Jun 2011 14:23:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=n/6AXdd/i1qp
	lQy7eGAQ679cFuM=; b=hCpSdLYziHqKO0U62l0vr7rvPKkYwqdwN1JIEBYhPK2l
	aE8r2i631CZO5I4Mhwzq2q7sdSA6pL0RletvT3rybyPP4/LqKjaW7Y2qDhEJm92K
	3Yuj7QFV8th1il+yJwbFlqIN5nPvbS6Un/YVjWVim22OcHztrtr5BU2ShcJG0Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ECbat6
	XXAcCzmoeMQ9XD1NyNFEufgXwDw6OzfB8r9km/o2ds/pM8eLP4A6UCFBf2hC73cE
	7kKmnutnMRpDYXjER4ZdC290IryqfYFnAoC/tW+oc30HyVnCEi0j6uaVdkOC+xBs
	/VBuPHrTWDeZmXfd3UYYT1q8JoRMkzhU+qYmg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CCE874A7E;
	Mon,  6 Jun 2011 14:23:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0A5054A7B; Mon,  6 Jun 2011
 14:23:21 -0400 (EDT)
In-Reply-To: <BANLkTi=SVZPebW2YXRnaLvkxEDGy_rrtJ3jayt8Oco6Sn8hciQ@mail.gmail.com>
 (Alexander Neronskiy's message of "Mon, 6 Jun 2011 10:26:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12CB667A-906A-11E0-990C-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175147>

Alexander Neronskiy <zakmagnus@google.com> writes:

> Explain the exchange that occurs between a client and server when
> the client is requesting shallow history and/or is already using
> a shallow repository.
>
> Signed-off-by: Alex Neronskiy <zakmagnus@google.com>
> ---
> =C2=A0Documentation/technical/pack-protocol.txt |=C2=A0=C2=A0 87 ++++=
++++++++++++++++++-------

Hmmmm, why is this patch riddled with these &nbsp;s?

> diff --git a/Documentation/technical/pack-protocol.txt
> b/Documentation/technical/pack-protocol.txt
> index 369f91d..f576386 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -187,26 +187,28 @@ server determine what the minimal packfile
> necessary for transport is.

Linewrapped, perhaps by your MUA.

>  Once the client has the initial list of references that the server
>  has, as well as the list of capabilities, it will begin telling the
> -server what objects it wants and what objects it has, so the server
> -can make a packfile that only contains the objects that the client n=
eeds.
> -The client will also send a list of the capabilities it wants to be =
in
> -effect, out of what the server said it could do with the first 'want=
' line.
> +server what objects it wants, its shallow objects (if any), and the
> +maximum commit depth it wants (if any).  The client will also send a
> +list of the capabilities it wants to be in effect, out of what the
> +server said it could do with the first 'want' line.
>
>  ----
>    upload-request    =3D  want-list
> -                      have-list
> -                      compute-end
> +                      *shallow-line
> +                      *1depth-request
> +                      flush-pkt
>
>    want-list         =3D  first-want
>                        *additional-want
> -                      flush-pkt
> +
> +  shallow-line      =3D  PKT_LINE("shallow" SP obj-id)
> +
> +  depth-request     =3D  PKT_LINE("deepen" SP depth)
>
>    first-want        =3D  PKT-LINE("want" SP obj-id SP capability-lis=
t LF)
>    additional-want   =3D  PKT-LINE("want" SP obj-id LF)
>
> -  have-list         =3D  *have-line
> -  have-line         =3D  PKT-LINE("have" SP obj-id LF)
> -  compute-end       =3D  flush-pkt / PKT-LINE("done")
> +  depth             =3D  1*DIGIT
>  ----

This change splits the earlier "upload-request" that consisted want-lis=
t,
have-list and compute-end into two phases.  The first phase described
above is where the client tells the server what it wants, and what it
doesn't have (by giving the "shallow" boundaries), and possibly limits =
the
"wants" by depth. The second phase is described much later and consists=
 of
the "have" and "done", which comes after the "shallow-update" phase (wh=
ose
description is new).

I think the separation makes sense, as there is a lot to talk about wha=
t
happens during this phase.

>  Clients MUST send all the obj-ids it wants from the reference
> @@ -215,21 +217,64 @@ discovery phase as 'want' lines. Clients MUST
> send at least one
>  obj-id in a 'want' command which did not appear in the response
>  obtained through ref discovery.
>
> -If client is requesting a shallow clone, it will now send a 'deepen'
> -line with the depth it is requesting.
> +The client MUST write all obj-ids which it only has shallow copies
> +of (meaning that it does not have the parents of a commit) as
> +'shallow' lines so that the server is aware of the limitations of
> +the client's history. Clients MUST NOT mention an obj-id which
> +it does not know exists on the server.
> +
> +The client now sends the maximum commit history depth it wants for
> +this transaction, which is the number of commits it wants from the
> +tip of the history, if any, as a 'deepen' line.  A depth of 0 is the
> +same as not making a depth request. The client does not want to rece=
ive
> +any commits beyond this depth, nor objects needed only to complete
> +those commits. Commits whose parents are not received as a result ar=
e
> +marked as shallow.

=2E.. on the server end and will be sent back in the shallow-update pha=
se
below.

> +Once all the 'want's and 'shallow's (and optional 'deepen') are
> +transferred, clients MUST send a flush-pkt. If the client has all
> +the references on the server, and as much of their commit history
> +as it is interested in, client flushes and disconnects.

Hmmmmm, are you describing "everything-local then flush and all-done" i=
n
do_fetch_pack() with the second sentence? If so, placing the descriptio=
n
here is misleading. In that case, I do not think any of the find-common
exchange starting from the "upload-request" phase happens.

> +Otherwise, if the client sent a positive depth request, the server
> +will determine which commits will and will not be shallow and
> +send this information to the client. If the client did not request
> +a positive depth, this step is skipped.
> -Once all the "want"s (and optional 'deepen') are transferred,
> -clients MUST send a flush-pkt. If the client has all the references
> -on the server, client flushes and disconnects.
> +----
> +  shallow-update    =3D  *shallow-line
> +                      *unshallow-line
> +                      flush-pkt
> ...

This is not a complaint to this patch, but I had to read the above twic=
e
to realize that the paragraph "Otherwise..." is not a continuation of t=
he
detailed discussion of the "upload-request" phase, but is a preamble to
the next "shallow-update" phase. It might make sense to give a subsecti=
on
heading to each of the phases, like...

    Packfile Negotiation

    1. upload-request phase

       After reference and capabilities... (preamble for this phase)

       ----
         upload-request =3D want-list ... ABNF
       ----

       The client MUST send all the ... (detailed description of this
       phase)

    2. shallow-update phase

       When the client sent a positive depth request, the server will
       determine ... (preamble for this phase)

       ----
         shallow-update =3D *shallow-line ... ABNF
       ----

       ... detailed description of this phase ...

    3. common ancestor discovery phase

       Now the client will send a list of ...

       ... likewise ...

Thanks.
