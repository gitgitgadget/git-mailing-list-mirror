From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Document pack v4 format
Date: Thu, 05 Sep 2013 13:26:10 -0700
Message-ID: <xmqq1u53hv6l.fsf@gitster.dls.corp.google.com>
References: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
	<1377917393-28460-1-git-send-email-pclouds@gmail.com>
	<alpine.LFD.2.03.1309030156410.14472@syhkavp.arg>
	<alpine.LFD.2.03.1309030231350.14472@syhkavp.arg>
	<CACsJy8CZP+55nhfEbgRGa9=y0PyExyHt_seiSc23kB31-_c1Hg@mail.gmail.com>
	<CACsJy8CzpW_xsoxU=+OE6ssbnPu9tyAqRten0=Q5cxPUZ4aeMw@mail.gmail.com>
	<alpine.LFD.2.03.1309042350560.14472@syhkavp.arg>
	<CACsJy8BeU_01c0f5RJExcYo7xGETnduKOw-_shszHd0ZFgZDXw@mail.gmail.com>
	<alpine.LFD.2.03.1309050024090.14472@syhkavp.arg>
	<CACsJy8CX=4Oz_h2NtS3FRdK6_zdFksa+JR5C6Z-z3Y70PLAsyQ@mail.gmail.com>
	<alpine.LFD.2.03.1309050131000.14472@syhkavp.arg>
	<CACsJy8DKL9KnPAXcf+NPU_Y5J1Dz_pYxSpONN4LxcQVi1JOBYw@mail.gmail.com>
	<alpine.LFD.2.03.1309051311070.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 22:26:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHg8H-0003LU-P8
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 22:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab3IEU0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 16:26:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755564Ab3IEU0S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 16:26:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83F5F3F183;
	Thu,  5 Sep 2013 20:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s8zcEdzE8Sh/g6ByLIkaqlm5lU8=; b=HDFfqe
	H5g4Hnveb0xkhh1FMi81wdY5vot6oICS1Z+A/o/aSuUC/8dNRzhsnrW0f9J/PpxU
	avHzeN4p8rzwZbqrMbOsjyL3AXYoHYlYgkQXfIKChCmLwlR4NJQRB9ddw667T/0B
	AXBI41TzSc0uabQ7HZh83kZQCQRZnqIoCEFpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OYYGYpJCpmDjFKfjOUXfBDVZlfbquqbl
	dLP2Jfz7ZkYYd1OlmC/L6Kv4svvl/wXZJdkmi3XP3MBQjQzetZtJrc7T94Ne3KNt
	yKRH4Xyb9n4nym86wnSPWWI11Fzl0ntYG3awr0EbBiaONwa8xnxhCTYHoQ7FZ/nT
	je6T7+3FZCk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12CCD3F181;
	Thu,  5 Sep 2013 20:26:17 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD4A93F16F;
	Thu,  5 Sep 2013 20:26:12 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1309051311070.14472@syhkavp.arg> (Nicolas
	Pitre's message of "Thu, 05 Sep 2013 13:14:11 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 68B42F7C-1669-11E3-A9EF-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233989>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Thu, 5 Sep 2013, Duy Nguyen wrote:
>
>> On Thu, Sep 5, 2013 at 12:39 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > Now the pack index v3 probably needs to be improved a little, again to
>> > accommodate completion of thin packs.  Given that the main SHA1 table is
>> > now in the main pack file, it should be possible to still carry a small
>> > SHA1 table in the index file that corresponds to the appended objects
>> > only. This means that a SHA1 search will have to first use the main SHA1
>> > table in the pack file as it is done now, and if not found then use the
>> > SHA1 table in the index file if it exists.  And of course
>> > nth_packed_object_sha1() will have to be adjusted accordingly.
>> 
>> What if the sender prepares the sha-1 table to contain missing objects
>> in advance? The sender should know what base objects are missing. Then
>> we only need to append objects at the receiving end and verify that
>> all new objects are also present in the sha-1 table.
>
> I do like this idea very much.  And that doesn't increase the thin pack 
> size as the larger SHA1 table will be compensated by a smaller sha1ref 
> encoding in those objects referring to the missing ones.

Let me see if I understand the proposal correctly.  Compared to a
normal pack-v4 stream, a thin pack-v4 stream:

 - has all the SHA-1 object names involved in the stream in its main
   object name table---most importantly, names of objects that
   "thin" optimization omits from the pack data body are included;

 - uses the SHA-1 object name table offset to refer to other
   objects, even to ones that thin stream will not transfer in the
   pack data body;

 - is completed at the receiving end by appending the data for the
   objects that were not transferred due to the "thin" optimization.

So the invariant "all objects contained in the pack" in:

 - A table of sorted SHA-1 object names for all objects contained in
   the pack.

that appears in Documentation/technical/pack-format.txt is still
kept at the end, and more importantly, any object that is mentioned
in this table can be reconstructed by using pack data in the same
packfile without referencing anything else.  Most importantly, if we
were to build a v2 .idx file for the resulting .pack, the list of
object names in the .idx file would be identical to the object names
in this table in the .pack file.

If that is the case, I too like this.

I briefly wondered if it makes sense to mention objects that are
often referred to that do not exist in the pack in this table
(e.g. new commits included in this pack refer to a tree object that
has not changed for ages---their trees mention this subtree using a
"SHA-1 reference encoding" and being able to name the old,
unchanging tree with an index to the object table may save space),
but that would break the above invariant in a big way---some objects
mentioned in the table may not exist in the packfile itself---and it
probably is not a good idea.  Unlike that broken idea, "include
names of the objects that will be appended anyway" approach to help
fattening a thin-pack makes very good sense to me.
