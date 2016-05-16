From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Mon, 16 May 2016 15:02:40 -0700
Message-ID: <xmqq8tz91x1b.fsf@gitster.mtv.corp.google.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
	<CAGZ79kacKnBjzVFSShRido4rKa3-Zg465d2320M6w1qXEkOZqw@mail.gmail.com>
	<xmqqh9dx3nsf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZyPvAFG1TjSm76LuDLpch=7iuL_-8LYqysSESFQj-YjQ@mail.gmail.com>
	<xmqqlh391z2v.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZuMdWdw2kcfs_P-_Ax1zXpKNHqMjNL80hBj3=SSp2zSQ@mail.gmail.com>
	<xmqqh9dx1xku.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbJxf6qnj1vqkbFzXBU+6Cfh6RMvs2NqqeASZAPLFXu8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 00:02:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2QbB-0008Ex-BA
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 00:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbcEPWCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 18:02:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751039AbcEPWCo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 18:02:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EEB001CB13;
	Mon, 16 May 2016 18:02:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9VesJKBmlb23DMchdUdOl4DFRLA=; b=PUqEm2
	XX4wKc8ox0lnzGMnnOicYTpNEP0Gn115+sbwV2LnmU/0C2MLYrLkM5Zx1TCXdgbB
	l89WgVLU7DxNFUUlZj2/yVWL57IkEDwI6nT6gXiTGOOx+BB+69Bl7EqdaN1m/ZsE
	eWdjviqUN+50g9RYXmActs/K6TSA0Vos9t5Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l52oICG4gn3/GS5nCzW+9NI0888q8zxv
	bONXYOshG5rWA/n+Uypc3AG1CUWUn90+bsEcd02iUu+oUqKy3I8NEAAW/QoZggIn
	+7M46vYVpystlSBs4ldZ5P3NOi2yKTMlCRojijlrD2wLZBfBzEMCSBhy8Pkma7lV
	nABTs798144=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E4D051CB12;
	Mon, 16 May 2016 18:02:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D4421CB11;
	Mon, 16 May 2016 18:02:42 -0400 (EDT)
In-Reply-To: <CAGZ79kbJxf6qnj1vqkbFzXBU+6Cfh6RMvs2NqqeASZAPLFXu8Q@mail.gmail.com>
	(Stefan Beller's message of "Mon, 16 May 2016 15:00:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E99D5406-1BB1-11E6-8F95-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294804>

Stefan Beller <sbeller@google.com> writes:

>> Hmph, why not?
>
> We need a namespace for which
> * we can guarantee that it is for labeling purposes only (even in the future)
> * is obvious to the user to be a labeling name space
>
> Starting with "label" offers both?

Ah, of course.  I thought that you were trying to limit ":(attr:<attribute>)"
magic only to attributes that begin with "label-", which is where my
"why not?" comes from.
