Received: from send54.i.mail.ru (send54.i.mail.ru [89.221.237.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01429230BDB
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785228113; cv=none; b=SWjkCTBcVQjuJzRZP1ufxNoIttDAsJptEi73ChIZq1vWbYkEGdhPZRIKXozxdCiZREh9Zp0P4VVkxdQ8dfLichkp0YbFdS86D3u036TIHOMYY6b288ks8HsW/Gn4eownN+kf9xzN0w0KpcvsM/Ldx+G8SjofVlMtGJhgdSwpS6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785228113; c=relaxed/simple;
	bh=XErFIk0ZDETyUS/OjN1IyEEVXeVsz2o13d9JLGZJPCM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ph7pdRvjZ+slMVNjfVBc3YjtVC0fssvz/wkPAfhsowDgLr61rUyEYP0v4ZZpbIgK3zQ9/Vbvs8d3pUlGFk0YrRU20xFhR3iyTECqSPoX1NK7fkCm4eHWT55AfWyzYeliTUFdL2kbHT9hQcv0I7X7gU94L1Qk6U+hKEBvhcA7HyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=z+1mOIrr; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=gfrov2Nz; arc=none smtp.client-ip=89.221.237.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="z+1mOIrr";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="gfrov2Nz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=pA8o2OeWtAUnuG7d5sBrR4mE5SD+wQwLwxBNTh3ES1I=; t=1785228109; x=1785318109; 
	b=z+1mOIrraLMDcGeEnmNMxLlH6cDHz5BlZktBQwFyhZYI/ycfdLE8ztyWxSmjypxzyDAyhUP7uuT
	gXYb4YaxIh1kq6WFrDThmWbsGjCTNd9vWfDaa/cE4Gr11MY0TrPuAxLiDvEuGRy5HYLErpm4u9AOO
	ql2Rvm9laDf0FbnmPzduiheUsvHhucQtZjG8AW/0AFmzVf/fhlGmNlCB2NEXGmn2NVNEw6amzXLb4
	CD4HMnOnjz1UzVh7CCHlKNGM0oG3jBh9jqCDLzyqQNQTP+Y99d2GFwemokifVNpUwvzPKVD1Lc1oW
	aNMbZOAXVLYbxVtSwbqjLgknHrQL7CaR6bqA==;
Received: from [10.113.154.169] (port=46810 helo=send278.i.mail.ru)
	by exim-fallback-5cf4fc9bf6-zj7fh with esmtp (envelope-from <long76.git@mail.ru>)
	id 1wod95-000000007By-1NKH
	for git@vger.kernel.org; Tue, 28 Jul 2026 11:26:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=pA8o2OeWtAUnuG7d5sBrR4mE5SD+wQwLwxBNTh3ES1I=; t=1785227199; x=1785317199; 
	b=gfrov2Nz5TBDqbqA+d6lVnxvSLPspdIwIVzMsCSsSFuaImWFmnSz0dRJTtGEa9lgSLTKqZkAGB5
	eZuF6fFx9w1WcY+J8++TosFqlO/fkwT8K20GLT3JZ+f43A4oV4T545Qt4Sqs4Fr5+KEPp7fA1N2Qw
	zzojxhjA9DW9vPuLl66AH3FrlY5NA5UK7Z5hrrQlAAQzL7Gpw9jtZJfQX7jwMMV89eG1IkiJ+FP9y
	y1gM7Ih2mgasamutNEHFwlCb9+2YSPmGLAL4BWvweo1T7lG385/7/wTWNaHRw8I/zU3mRLt9QZL/+
	ugDAF0A7mu6C5bVnzTuB6R8RiApe7F62ZtDQ==;
Received: by exim-smtp-6c76488b9f-8glpg with esmtpa (envelope-from <long76.git@mail.ru>)
	id 1wod8w-000000003oy-2hWn
	for git@vger.kernel.org; Tue, 28 Jul 2026 11:26:31 +0300
Message-ID: <edfc868b-6be6-4871-a539-e70791db216d@mail.ru>
Date: Tue, 28 Jul 2026 11:26:29 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, ru-RU
To: git@vger.kernel.org
From: Long 76 <long76.git@mail.ru>
Subject: REBASE_HEAD still exists after success end rebase
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD93AE80F4FE6181E4F1628ED37B610B6442EA28E42FE12C9A6182A05F53808504042CCE5522733214D3DE06ABAFEAF67050D2D2478E385988DF8363BD8C781F7C3FB1AA341019AC2B8
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C2204D4F9A221771EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375666E0AFCC7CBCEC7C70597FE6F0E2750EBC16C0F217943397900DEE43A098DC29D8EEF46B7454FC60B9742502CCDD46D0D9E541A154B51D14BF6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249B0E9FD5D4288160ECC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C045A75973B56231AD8941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0F206494F22AA87D6D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE362B3BD3CC35DA588BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C37F2E9035E9FA3B8235872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5F0A4FE07AE7E3BE65002B1117B3ED6963835BB1B293EF33D54BB1175C6E7DD94823CB91A9FED034534781492E4B8EEAD491B7F2495B7DCE6C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659A611480346927E0AA3F92EB898ED643955956DBD112D65CB32C1DAD23C334769507DD5121BE02A77B8341EE9D5BE9A0A1C1F1CDC506315819679A7E8562E785C2C97CFABFF52DDFD52EE4E5D9E54FDA44C41F94D744909CE06349EBF80BA53DC7F80F8B16B0B4F5BC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVczkDsfooUjfYzTZ3xrlqIk=
X-Mailru-Sender: BF619F039C5E48B05804D9064179567ACFC4FEA5F9F4E57AB951B70A5BD4BD8EFC91B8E0DF0E3FF45F9045B74F665CC8425AE62B7EC354419CA68C07A4EE0065362722A76DE2BCCC34372B9448EDC0929956202DFC8A2C27324D571D86A1F4E42D063C67CFD4E84967EA787935ED9F1B
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B41153A78F4023D798AB6565AD5806B5EA4D6119D097D08A05B647ED114AB003AC6D60E98ACA21A2CBAC4385294E02B5FB5AA90AE450F532CFDE06E3894AC1A351F3A2C4E99DBE10D3
X-7FA49CB5: 0D63561A33F958A54C90D348551511615002B1117B3ED6967FB09263A6E5EE3EAD864E5BE48A9E5E02ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZRUBLxC85WEBi8N0Vl0Zq4g==
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

Hi,
My configuration:
OS Kubuntu 24.04
Git version: 2.54.0 from ppa:git-core/ppa

.gitconfig
[merge]
     guitool = meld
     tool = meld
[core]
     editor = code -w
     autocrlf = input
     quotePath = false
     eol = lf

[global]
[diff]
     tool = meld
[gui]
     editor = code
[fetch]
     prune = true
[mergetool]
     keepBackup = false

How to reproduce:
1) Made repo
# Init repo with README.md
git init
echo -e '# Git rebase bug\n\n```\ngit rebase master\ngit mergetool\ngit 
rebase --continue\ngit rev-parse REBASE_HEAD\n```' > README.md
git add README.md
git commit -m "docs: add README.md"

# Add feature branch
git branch feature_branch

# Add files in separate commits
echo -e "Text 1 line\nText 2 line\nText 3 line\nText 4 line\nText 5 
line" > Text1.txt
git add Text1.txt
git commit -m "feat: add Text1.txt"

echo -e "Text 1 line\nText 2 line\nText 3 line\nText 4 line\nText 5 
line" > Text2.txt
git add Text2.txt
git commit -m "feat: add Text2.txt"

echo -e "Text 1 line\nText 2 line\nText 3 line\nText 4 line\nText 5 
line" > Text3.txt
git add Text3.txt
git commit -m "feat: add Text3.txt"

# Do the same in feature branch and one more in one commit
git checkout feature_branch
echo -e "Texts 1 line\nTexts 2 line\nTexts 3 line\nText 4 line\nTexts 5 
line" > Text1.txt
git add Text1.txt

echo -e "Text 1 line\nText 2 line\nText 3 line\nText 4 line\nText 5 
line" > Text2.txt
git add Text2.txt

echo -e "Texts 1 line\nTexts 2 line\nTexts 3 line\nText 4 line\nTexts 5 
line" > Text3.txt
git add Text3.txt

echo -e "Texts 1 line\nTexts 2 line\nText 3 line\nTexts 4 line\nText 5 
line" > Text4.txt
git add Text4.txt
git commit -m "feat: add all files"
2) Call — git rebase master
3) Call — git mergetool
4) Call — git rebase --continue
5) Call — git rev-parse REBASE_HEAD
Last command return value and .git/REBASE_HEAD exists.
In other words REBASE_HEAD exists if ogirinal commit in new branch 
modified and need call git push --force to send it to server. Please fix 
it, thanks!

--
Long76
