Received: from send239.i.mail.ru (send239.i.mail.ru [95.163.59.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698104D98E6
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648279; cv=none; b=Vh1w2YhnDICPkb20bOh67FS9LGdgHj/UEqc8YcnLJ7SrbFUjM+w3wlw1e60tf1BZtSuaB79d+ILslDdkQbC7WcbX2VfqAVn3CebiewXY2hpYvxbzwG7CtvH+ByLJUFJxU2fzVPXOrlYrblJiSkQm//6H0xruXZ6ZkUbObsWNt3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648279; c=relaxed/simple;
	bh=TJoNnkI57mEO79NcjKLFflxx3Mt3z0pVBQLbTrt3x6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3HNdyHHbCHnSbkR03skiquJPvkYUEz2CfPPF+ARtKpv/UoG2LxvqLGNN7pmdn7DREvS2SuPzOnnr8Ao7kfOOrqLgIrl/EEKtHEKDzh2ui6wvfqGfaRYBuDwxP3MGH9DZIrGLs/LQXjH0+2H+wXLTvM2/m7rdcHcZjH0w6zHr0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=jtjmLkbV; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=smNsuePd; arc=none smtp.client-ip=95.163.59.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="jtjmLkbV";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="smNsuePd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=TJoNnkI57mEO79NcjKLFflxx3Mt3z0pVBQLbTrt3x6g=; t=1789648273; x=1789738273; 
	b=jtjmLkbVSDM2O5N6p5gSsuL02lCac3QLhtnH06NnvmGYxDUK9Z30BwHr8PCV6Toz3DiC+jduddU
	VzW6CA5gtyeopatSQqjwjiypmqEq1OutWQ0cL6vGJyOnKaF3L/0N7w3Cx18lfW6jM/FomW1ZnRjrv
	JERSO60z2GxFXXeNaq6GC9ad1pvwCePAsjEn7Eez2NpqXsdGXwrQIXWeYPaqtf46SAyr22cVE0V6v
	6gWLlG2aZOpoVTDaOJYL48OiewgfWI+cnOuVecElboQd5mgpxJTNm54tHgAh4lTL/g8ovWR4hGkm8
	j774tt2fJB9jtkl+vSps4s9PXO6hyw8AAnrA==;
Received: from [10.113.128.91] (port=57274 helo=send81.i.mail.ru)
	by exim-fallback-747658684b-n82cq with esmtp (envelope-from <ub4nal@mail.ru>)
	id 1x7BGX-00000000Apt-14TJ
	for git@vger.kernel.org; Thu, 17 Sep 2026 15:31:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=TJoNnkI57mEO79NcjKLFflxx3Mt3z0pVBQLbTrt3x6g=; t=1789648261; x=1789738261; 
	b=smNsuePdaPOdYBg4aGa48d09V3r3bxLOJ73MXUIJAhw5Kk3iGuaZ/U4c3OIXOPxxoHnQoJEfgx7
	q+A7w92PpU/RoAz+Ywka9keSUQhRkZNS5sdZT1XCoByyYjC/ST7QGtLgfQIQtG8/A7XKbi9XyZw5V
	IiSeZm16HY3AXzb20xalcNSfmXA88gEecjmMmElOIKPqHvMuHw9JygovczWtPN4iEYqpJ/uQc98OZ
	bh//aEOoB7zqt0Jg6NsYymdO8rJGctEx29UEksV/TjkSZ7Jdb0UrM8uCq0AtS9Ugc6uSnYy4ut/wV
	ztmUVnE7cY2+WevrmwixaxrXGY6EOf75eetw==;
Received: by exim-smtp-759f5f99bf-hj2t9 with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x7BGO-000000009Hw-2SGI; Thu, 17 Sep 2026 15:30:52 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id 716DE9F664;
	Thu, 17 Sep 2026 17:03:50 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: gitster@pobox.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.net,
	peff@peff.net,
	ub4nal@mail.ru
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
Date: Thu, 17 Sep 2026 17:03:50 +0300
Message-ID: <20260917140350.44760-1-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <xmqq33vb4hma.fsf@gitster.g>
References: <xmqq33vb4hma.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD964331FA9A592EAE90807CE87B91C25BE7C94775145490474182A05F538085040D5A9887FCC7EAEEF3DE06ABAFEAF67052CFAEA06563D2158165351F9CDCCF010A3221720B8975CE9
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE736691C7D10565E03C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7DECE8D0A5E25C0FCEA1F7E6F0F101C67CDEEF6D7F21E0D1D9295C2E9FA3191EE1B59CA4C82EFA658599EF80DD2026AC84299CD39E652F15A0188C957097511CC6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE70A7D3DE80C90AF369FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD18CB629EEF1311BF91D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC2F22DFD7D6B35478D81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE75C623DA9A0966939CD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6ACE00135B021D8CA089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5D2F05D2F93C1AE065002B1117B3ED696A19703ACC5662E26A13BD6A4B0E00B96823CB91A9FED034534781492E4B8EEADE0C144949FACE77EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F96AB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D65958B0C72D060CC9C6635EE477C40E17DC4F3B496EF3C873B9D9BC3E6A0F527000B89A2255725F62F9B8341EE9D5BE9A0A3479312E7C90880E71F288250CAF27D984AD7E8A344BF6F7721D270AA2B885D14C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWOdpeQmMVMm/DLEd9SnCO68=
X-Mailru-Sender: 288943BA7BCC8BBA6F20945A9C1CCD21E9035304C611AEEC3DE06ABAFEAF67052CFAEA06563D2158A165F1893FAC5C75730F10A35ECD6C905A92E71CC7C3152D8DFEC3831B33C4D004BC3E28E37B34A4E9BE5789416A142FC25A2993B28EC86D9FF92CA8FAC60DF8EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4B946B743FA8A2A26DB66055FCB707F902DBF724CB0A618D8049FFFDB7839CE9E07574EB8DB9E0903B0C4338C545CC52DF5085FA2F2230459B35BA142379925F64B83BF6B8200168A
X-7FA49CB5: 0D63561A33F958A5753C5415E8A11E705002B1117B3ED69657D7894D4F0F5C0575CAC6BD4D76D0B202ED4CEA229C1FA827C277FBC8AE2E8BB6E4CD11D81D7E17
X-87b9d050: 1
X-B7AD71C0: 6FEFE4C63DFE2D851629A3278334FCEC2AD323669803AD9FE6E38E9349F0B966DE29794C28DD25AC8A181F4B97039E94
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a+L6MG2f5Y/GkoCRFsyJ4zw=
X-Mailru-MI: 20000080020001000000000800
X-Mras: Ok

Junio C Hamano writes:
> So to conclude the topic, we would only need this?

Yes, I think this is indeed where we were heading.

However, during the discussion I really liked the idea of passing a pointer to the "advice_setting" to "vadvise()" instead of passing its individual fields. It seems like a cleaner interface, even though it is not directly related to this fix.

Would it make sense to submit that change as a separate patch?
