Received: from send215.i.mail.ru (send215.i.mail.ru [95.163.59.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5A2D2493
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541203; cv=none; b=u04+V/6tV+cZrEuM3msqOq/N+joycY51rZ6DoozgduswNdPFbyBsEaiqpWgHr3oFEu9Sjb+1eYYHN9WYvwlQB1jQhg14ZseyfwYSGXLh42kTJtCyltemwZY3uzmIEPcCpnnenh9608vHEpV6S5qSAmvBgBmFHc0UwKqpP6RzrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541203; c=relaxed/simple;
	bh=XwdmkuZ9FA4BNUVJktNQQqtWQXvbjbCOEG8yZMPxDeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnJDGN+49d//WiSoTV+b7NrSBalbMVahrbvp09Ie1vtgMDbYMJxPyIFyJpd0RdRy4AyhyVzX7/bDnKLOs75UK2Cbv1MvFQXNL7zOBYgm7xuQ8pwCVOk0bSk4tZQeMVgI9tjqIvRjdSiDuBczj41jSAFtoPu1+8WP+/u4pu9Vu2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru; spf=pass smtp.mailfrom=bswap.ru; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=JxW88w4o; dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b=IqA3exh1; arc=none smtp.client-ip=95.163.59.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bswap.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bswap.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="JxW88w4o";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="IqA3exh1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=YcWLARCgQoaf9Rllr3xlb2SMyNcnHfh+D9yrPSgX79Y=; t=1755541197; x=1755631197; 
	b=JxW88w4ofo+xgQRtWQe+7N6iNnsgfS64U4Q6HEfJ2Tje3uFdOluWSMeGV7edbzCQq4sQnSCJk1h
	UeazvkkZPJ06giuLdRkv6QgpRv+HGDrZDK2h8HjWgXizLZnQ/7XF4sgVPVLqpax+QZCnd03vyWO2N
	n8IzMb0ejXfYW8Wt594=;
Received: from [10.113.84.167] (port=37754 helo=send172.i.mail.ru)
	by exim-fallback-847ffd47ff-74jtg with utf8esmtp (envelope-from <kostix@bswap.ru>)
	id 1uo4Du-00000000Nlj-3MGp
	for git@vger.kernel.org; Mon, 18 Aug 2025 21:04:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=YcWLARCgQoaf9Rllr3xlb2SMyNcnHfh+D9yrPSgX79Y=; t=1755540286; x=1755630286; 
	b=IqA3exh1XGAEKyEL3fSudc4Mm055UNenKdKutuRKm6XF9oTMOBZwjkPf1pMmywC0aW04ysfijCX
	HcA+Ogos69zvNpetkuTs4dWmP7OxZi8lKqljVlFynB11t/NapE4UeB8grpKn2AeGQlzO9ShqjGr/7
	qClosG6wV6o4GVtwkGE=;
Received: by exim-smtp-7bdf5d4766-qc5lc with utf8esmtpa (envelope-from <kostix@bswap.ru>)
	id 1uo4Dl-00000000C6N-3frc; Mon, 18 Aug 2025 21:04:38 +0300
Date: Mon, 18 Aug 2025 21:04:37 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: "R. Diez" <rdiez-2006@rd10.de>
Cc: git@vger.kernel.org
Subject: Re: Graphical tool to merge and reorder commits
Message-ID: <ph6tcb3xncqhunxoh5mr3rrjxi3vbo6tekcjx3dv5lfks5giw3@nya6ss4tpmoe>
Mail-Followup-To: "R. Diez" <rdiez-2006@rd10.de>, git@vger.kernel.org
References: <4398af77-3183-4ac5-9a25-aca6289d8c8f@rd10.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4398af77-3183-4ac5-9a25-aca6289d8c8f@rd10.de>
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD98963C40F031035C884619EC99958E57CA45D10DDCCD1CE73182A05F5380850407B83432B4383520B3DE06ABAFEAF67058910AED452771F88678C34A1C3F39B53E32BF596A4C5394D
X-7FA49CB5: 4BFC5D8501E51E47CA8F6BE7C18995EBF17A87A2884587766DF24F459E69AFB605CFD1E830D3A308707937C1A3B2EB35382A44476A7729E5A6333920E0F9D84FAA484E9BD3D4964B0190A62B4F10741F646C2A33599DE4AAE47410EB8219D4D82737C91DF52F51B52FC41DEFC96C1EDA644B5DB212AD3DE6B1E994F4684A9CD8AC5E31D140C561567259D723EF62CBF8558C44A7E910C4F0E35907F946520C92B418B27BD9AE4CCB63A17EB2A3824495F01C4FAB541DE28FC6CB7D05AEC4C6A97259D723EF62CBF8CD57035CC7A4315E926A0011934001A88CC2A23726E83CCB646C2A33599DE4AA0029EA78C05A4DD7B0B56F9AF285FF2A3A0932D714ADE7D989D178B05733710662E4190FF6E96AEEEDA412B152283F289271CFB8AE809F5362E4190FF6E96AEE6EEED3D1F8F94EF67D90D22DA600F37E3896496414990D148B074CB69217DF89B96B5885278F711A9624F67765C4633C6EEED3D1F8F94EF6C2F20794B249F36DA3C43680391634B280B7D85A75362F291FAC779C63DA520C37C57B6F6A2FA07604E075B42E82A0FD3BE3556EF99D419D7C1E2FC510E251C2
X-87b9d050: 1
X-C1DE0DAB: B30BEEBCB9DAB3F0F6A07827EEF02B8C478DEAD3877DCF1619F2987A4361ADCB4EFFA0F248B3FC53BCC2DF43DD22AB26DB841BC0FD54B826FAA3AD05AE4F2DD42290FBF13227320B
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D349EC559D073CA5B68ED0AE7C4F21A359E6DB752A187C4F7C5AE7795C2F687C178D26CF4FB08B56C411D7E09C32AA3244C1ED5C349283AC6C177DD89D51EBB7742FEC8D6C9D919DFC3EA455F16B58544A2E30DDF7C44BCB90D3871D1C702CBDB0A9665A0FD7AD89E8F722DFA761B3F797A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVUcWHxAuDCnG44UoCU/8xjw=
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138070B3E12B7C554B8CFE9FA76EDA5B4B7C4B45113096BA9F05E5698B9E02565FE2F0A6AF357119A4D04176AAE5055CC72595A8557D9C981F4633CE835492D9647D182D770C8C7E642B4A721A3011E896F
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4CB46F01A5D3E0BE7CD2D28B857119D0F6E39A47A8E1A910068F3CF0E9FE49B69F359A30B6784021234E93CADF43DD72B4255407FE03501B1B96D316F497124B292EC383572E97193
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZ825LsZDQ+DHnEsClGAFfQg==
X-Mailru-MI: 20000000000000800
X-Mras: Ok

(Sorry, I have nothing to say regarding the very question you have asked -
as I personally do not need a tool you describe, but I have decided to chime
in anyway in an attemt to correct what I perceive as a misunderstanding.)

On Sun, Aug 17, 2025 at 11:02:53PM +0200, R. Diez wrote:

[...]
> Here are more details about what I mean. Say I have this commit history:
> 
>  A - B - C [master]
> 
> I want to visually create a test branch first, by dragging commits B and C
> together (merging them), and then appending commit A afterwards:
> 
>  A - B - C [master]
>  BC - A [test]

This is not merging, but rather is "squashing". Merging in Git (and in any
other VCS I'm familiar with) is combining together one or more separate lines
of history. In other words, something like

  A - B - C (master) - - M (new state of master)
                       /
  X - Y - Z (feature) -

would be a merge of the branch "feature" into the branch "master", with the
commit M having two parent commits: C and Z.

Squasing, in turn, is combining textual changes introduced by multiple commits
into a single textual change represented by a single commit.

[...]
> I have tried or investigated numerous Git tools
[...]
> They are all fine for normal commits and the like. However, most fall short
> fairly quickly. For example, the ability to highlight character or
> word-based changes inside a text line is rare. And none of them really
> appealed to me when merging, let alone rearrange commits visually.

Just a guess, but visual tools naturally tend to be tailored to the needs of
inexperienced users - to lower the entry barrier, and what you're after, to
me, appears to be a task not casually undertaken by the members of this group.

Creating such a tool properly - with some intuitive support for resolving
cases when, - continuing your example - rearranging "BC" and "A" would make
"A" fail to apply, and with unlimited undo expected from a GUI tool, wold not
be an easy task.

