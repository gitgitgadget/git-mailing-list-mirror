Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046347A0BC
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210246; cv=none; b=s3AaucbDdyGIG41q0RQemKjHT3MUdOX7KwaMcFtji3VUyNaK1y/wz8+YEne6OfGgk3KBnY20lsDcCY9RYmUuCezdAvZvQciOVvT6aWtIA5gEcy8d8twh3wwc3bgJw8NZDU9zOsBWd/8vZEeLmDz9m9CvlDO9MNOpyN3iu8keH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210246; c=relaxed/simple;
	bh=NlWobO9kj1z+8gbz/Wkl0WiDcRrcNERbhV86vtSosls=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=LusHZFlGRhDFkhgEUsDfgJJ/X+wpzLCLLDXN/M6IsOUnheLWmEc0mg0XhB4wWjqySz5yZp3DlsBuAJqwOljC47Ev8BBDtMlDuOPuFsZh47R7JRM1AH+gFwbHMh//ojhOVMt4Ay7axe4eaLkhn13lOomnz8oFTol6dd4PGwZaoPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=ferdinandy.com header.i=@ferdinandy.com header.b=iwQE3orB; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=ekaAGt/4; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferdinandy.com header.i=@ferdinandy.com header.b="iwQE3orB";
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="ekaAGt/4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-eu-zurich-1-20221230;
 d=ferdinandy.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=NlWobO9kj1z+8gbz/Wkl0WiDcRrcNERbhV86vtSosls=;
 b=iwQE3orBRd82C67fPslnNwSqPGN2L5HiGoMiJUyUi9/TWE7R+7pbEg8P3HF1JnEj41Y7DuKAOzmx
   OEW3LMYC1v6wU6Xz53za7DLAMLEGvByEsGkh6pCDFWGyOB2fDWRfoQKsJERk8k8xBmLqxHf4uOxG
   JeyXTqbqnPJ249HSCoQUfr/WSN3NM0P8WF8OcLSGu8jAKdsOzo3qfhGzMqMztWeFFy/zoCGQa2k4
   AuRSQ8cvV4grOBi3Y4p8XnkEAJ2mryp+Kr9DpJCkKMwKDVK/9+8ajVhaiOBy6vZhE9RTr+3iO0hA
   DouUlyDQSWmQnS6B6h1WpawDooB8YsKux9xcnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=NlWobO9kj1z+8gbz/Wkl0WiDcRrcNERbhV86vtSosls=;
 b=ekaAGt/4296/RUXQi7jEZM47HGH3VSYZUXmrAB+qHCiWq2Kr2J69jNq0XhgkoL7jQQM6k2DoBpNR
   UoiSX74QXADzgEn4TLcZmfmKR1/2sykFujbpnbE5QE7PaCvS2COchukIXGjYF5FXpGGOyFnUZSDO
   6I+Oz8px81zchZltiwqj/2TaUMapIsT3pmPX9I7Ii9zNAORzz4zIgdzcoOj23veTGLNbXdbT3M5j
   XY8qZWWOLb9cPPL6XdSmcRNJzRlHJPK+5wQxCix8hfTrSE6hfLKk++Vk3MD0c6m51ejha5RhY4fJ
   516uHBfIOxIuEXEyUzwMfeeOx0RKwFpjohyw4w==
Received: by omta-ad1-fd1-1402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260603 64bit (built Jun  3
 2026))
 with ESMTPS id <0TGH15GHGIMAD400@omta-ad1-fd1-1402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 11 Jun 2026 20:37:23 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 22:36:58 +0200
Message-id: <DJ6IBPYNOTTY.3QKEZQ28P713V@ferdinandy.com>
Subject: Re: followRemoteHEAD management question
Cc: <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>, "Matt Hunter" <m@lfurio.us>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
 <20260608234946.GB358144@coredump.intra.peff.net>
 <DJ5XE9HC5YNY.33U8AG1GX6ZP0@lfurio.us>
 <20260611060123.GA2187173@coredump.intra.peff.net>
In-reply-to: <20260611060123.GA2187173@coredump.intra.peff.net>
X-MS-Reactions: disallow
Reporting-Meta:
 AAHTTpoE3WbFaFDxn99v4S3WFaZZVW3J44woXdjMXZyV4QG9H5dTjEu1z831fmxK
 6qIJ2QHhgzjQaRu0HsWEM01Bl0HL5e++DTTsjFfUE3o61dpJyypVLCJggE7FiMRR
 Ko4EOk4Ubz29obeKjL2Dby6Fryrih2YHNQ43L65iWYNjJsV9j+EecpYmi5lEw0HL
 xNmUAnK5HDyS5jTzB92AKoFW3QwRoDoZ94Ig31IFFwPx5v8BdWp4QmJKW6R2bhfd
 BuZO4eacYzun1QYwSvqFj3SLo/bQx+tUfNeBTfuXWW3GLRAOnLP7al+Mh9iJ1CvB
 suCN4msN6CaOA87aFLKnE1vUYTXjmjzLUN/cRWhTDMqY8GaJbgfiOvGfZEdTJtka
 JA7qz4TbQsOwDaA0DEG2I51U+mvvs8pqAIXu+cAWOmo+1pDlHFmIuGEKeFLE

On Thu Jun 11, 2026 at 08:01, Jeff King <peff@peff.net> wrote:
>
> My initial thought is that it might affect clone as well as fetch. But I
> guess this feature does not kick in for clone, as it has its own logic
> for handling the remote-tracking HEAD. Though arguably it should be
> possible to configure it not to create one in the first place.

If memory serves well clone has set the remote/HEAD well before this and
I think it indeed uses a different mechanism/logic.

>
>> As for another design decision: I'm leaning toward omitting support for
>> the "warn-if-not-$branch" value in fetch.followRemoteHEAD.
>>=20
>> My take on that option as-documented is that it serves more as an
>> acknowledgment from the user that "yes, I understand that origin has
>> pointed HEAD at foo, please only warn me if it changes" as opposed to th=
e
>> user expressing that the branch "foo" is in some way special to them.

Yes, that was the reasoning. So I also agree on not adding it to global.=20

Bit late to the party, but happy to review/test patches if they come.

Best,
Bence
