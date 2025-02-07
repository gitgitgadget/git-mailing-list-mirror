Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B9194C6A
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738969865; cv=none; b=UQ9a/NLEX7ss2ppaZeK8q8Y9sI2106PFYorI29xlbISNxqub+BuJrHR6Q1kvhqt3s/gl6pA0Sw5Q0T8zwnbH4VzH4+XwihvQiBJOPVF0O3tYGD205zBqhqL4zFzQDDyMS/Jkk0NagbSsX8pSgRqcWri4UqKHfSqWNDWlTrSVXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738969865; c=relaxed/simple;
	bh=6UrAtvcr8+kGGtkThj0Uvdt8UJxI4aXSvZ/YJpGDCyI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nVxGHFzAK4Y+fO6KF497AqhkxrJU10fYH1ZrJeUr4cCRYTK8NhsnGv8BL+0oIgETyNzvztYMvejCL7idTChdNZCby2xo6LoRZNtIXUTThLMcq5wd/23KmURgv/qVenc5+bI42joyL2aCJprVMdqTe7f5CcoRTfXH0ijiDk9KSrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.jp; spf=pass smtp.mailfrom=posteo.jp; dkim=pass (2048-bit key) header.d=posteo.jp header.i=@posteo.jp header.b=RRnQRHVR; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.jp header.i=@posteo.jp header.b="RRnQRHVR"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D26FE240101
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 00:10:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.jp; s=2017;
	t=1738969859; bh=6UrAtvcr8+kGGtkThj0Uvdt8UJxI4aXSvZ/YJpGDCyI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:From;
	b=RRnQRHVRcjjWLdHU/2p4NlhMOmOtrQLR3R9Mgp2QkxmmZv4U2iJQalV+u8lc6wupV
	 JhjDEGo48rV9Ft/5bXflS7oQv9OMYOVapSkPRql/QVS2sbHNi/AeSRyW1iKk52EOqN
	 OKvWgNLo1tBbDGAPL+8CK1r6CcEA+YA89/ngPGx+SQKIP9cGcKsQhVPC9aZlLTeSz8
	 pwJA4/JJ38oYJnTiav2ooAErjvkqpjFNahgmA9sekWW+AWHtHxTgvIn3qiBZduCypZ
	 4Eb3LATBPxog8/jA3Dal+J6y8lFGjg4LGqWsur9hg+WxR7WcIr+sg3S59ESLiYUWRR
	 XJlrrl+zIJwOg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YqV830xQBz9rxB
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 00:10:58 +0100 (CET)
Message-ID: <f8a955d6-abfc-4368-a0b6-7a47f333729b@posteo.jp>
Date: Fri,  7 Feb 2025 23:10:58 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: git@vger.kernel.org
From: catastorf-effcalations@posteo.jp
Subject: git freezes ssh yet clones the repo only for the time of the ssh
 session!
Autocrypt: addr=catastorf-effcalations@posteo.jp; keydata=
 xjMEZ5/cIRYJKwYBBAHaRw8BAQdA4QV63QED1Ipdrj84+mbNA8fpu5yGGdILuZBDDRRs8lfN
 IyA8Y2F0YXN0b3JmLWVmZmNhbGF0aW9uc0Bwb3N0ZW8uanA+wo8EExYIADcWIQTuAytLJ9r+
 mdlMy4sRmZsQU3dV/QUCZ5/cIQUJA8JnAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEBGZmxBT
 d1X9ihwBALRvHTcKl6mYh8xUu2li86fEqIM7jxG9C4nDT99HoCzFAQD8yScnkhsiKxKM5noB
 4qYbYmYdbWxmC8sDJZCUQYTuB844BGef3CISCisGAQQBl1UBBQEBB0A/i2fyu8Ldo4pPwht9
 qHTTjPu3Kk18AOx8yJATJm9mSAMBCAfCfgQYFggAJhYhBO4DK0sn2v6Z2UzLixGZmxBTd1X9
 BQJnn9wiBQkDwmcAAhsMAAoJEBGZmxBTd1X9bJ8BAJmukmL6TeZtOCq19mf4uGpssQFKnQxx
 5aDbC7nVYEyqAP9Cg0nejTfYtLJyhr85P8KXomUzWzYvjHfABBQu+WiADg==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

just installed git server on a Debian remote machine.

I have from the following command :


git clone git@ii.pp.vv.44:sshPORTnumber/home/git/storage 
/path/to/desired/clone/directory

the odd of my repo YES being cloned locally from the remote machine YET 
all files locally desapear when I  Ctrl+C the frozen ssh session.


I hope your kind help and humbly this not be a bug.

Carlos.

