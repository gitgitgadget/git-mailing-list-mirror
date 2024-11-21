Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292CA2AE96
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732199342; cv=none; b=RUFqC/woao9vThzpiWUA+skYj1Q7xF5PPM2M0TVp6XvJ+qRjOaEo8XiRr6wskTblh1VyJJTbqUyLM6qKNztkITelS6R3+6a7ig9phGYEUprq3m838joHGN2Ty5a8ODR6a0CXAoqfkq+IiM7CExfnejN7W0DzO7/A2iGVwCgui0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732199342; c=relaxed/simple;
	bh=Pfa458UovAnNqDZsyDiIU0R9RsvpTtCW/1+TvluMn6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sW3wRuXell4DjcGcrQ4ONGfzMi8n5qBYA+8UGRrD85FK/zg65moOK3mUAbE4f5fl0GtH/B+TmRwuHpJ7/2GZsDr5V2lM+ON09kZX96FU+0tIn8JMpMHwaXdB4vh4IXe+UcSOpkTr52c4lwcju7D6rBeFUuY1sLdpCJ1x9qrUpkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eORarAJw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eORarAJw"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38245e072e8so937462f8f.0
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 06:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732199339; x=1732804139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BVrA4gNUQaTGZd3MyhFdInvO/n5n8tUJq9zb8LcFRWQ=;
        b=eORarAJwe1dqsuXfzYb2C5ft//U3gQDt3LLauABIa3/2D6mDs54B1U96evu7WvOI+m
         fSZZWpQy6xhULF13UG/+QC2QhV1RskqxdUNxW9YWi2rRfcpuuEJAWjYGxZlpzyQldRtO
         lswCkcX5S7A1CHoCMu4vnGkfFv7TBs25JbDzB0TYXUwsI+XMDy/gTfX4L/FPc6ufxsQ9
         BK6Kf8Ww9H56yyfTndU76eBO/FTREmtDpRuVt0ycjv/5xB1UQX1Xb35cSGCV413CpXWg
         xmQYisEB1YtDFUjfMZeiNBb6BzILS4Um4XDJZDnfnZZq78S/Fs7AOFTb1OxiXDnuAoG0
         NZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732199339; x=1732804139;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVrA4gNUQaTGZd3MyhFdInvO/n5n8tUJq9zb8LcFRWQ=;
        b=FGwdrqcLvk5NyTcXlvMjG8xqxkT19+IpD+MamXQMziQpu0dWZgjUFdTTvf/bzKjwRF
         Km0z/v6XdFLRmy/5xHKWW4ZYmPJzgYW/ee0iEJLwFJPSu9ZS7Ob9h5sK6HREwt/qG/il
         U8SDJkcP1jn/1J5T9UUqQ23ZbZeWh7U709DghmrmyJaFmU3RoLUETJxwixWG2+9vT8hc
         vfI2wVLHOLHNNZlIiHrFUte4BvjtUxxKxbHWFzjn5a6jwHUu/686eq63tDNpG+zQAfWS
         O7jBmuD+PDx0gbFlxpKaDSG7nJ3h4eSxfFVPEdBlD99xrOXlfVYQvFUozjx/6ZU8VIaJ
         MiOA==
X-Forwarded-Encrypted: i=1; AJvYcCV0zYfx9wu4EVxPuAln0xoFd0njrP70JFvd3UXJ14zWawowuCeuFwon/lzp9EoR/JXLf70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwVzsPhPOMOlMGYB2J1mq7XhK4+zvb+4FjT0djt16mBVIBmNo
	v/dltml1E73ElXCklu+L9l0mAD/EhS8zCp8PeqSLrNCaFmtZrzZXSgta4w==
X-Gm-Gg: ASbGnct1mcuCv94CuEK4SC3N0QOI9TLXAH7qohixtODoyO4RQhcdHD+rrAKVHzN7BRL
	jIj8xu7k+Fw79Rjiab8cno0yOqvDEz7txiILvCH9E6QM032Mva3V6uvtOmLe4xSFFkYD5vqvGOW
	qdp+5lfL5mDmOOuavRnFI704O6FIYI6QkRCaEcLvhHqmbjeHXib3jo3NxH//HmqjoHNFn+ux/qB
	R1ahWmPxnFWwLgFHejgXZ0Jm6z6JNG3jVnQGn5BDMpw16CNG5y1Pgp8PcdEf1Ka/60dbIosO0fY
	Ch2+1/1cnUZ6ZckUGwMz2JFnlw==
X-Google-Smtp-Source: AGHT+IGnalw4pB7Hanz6iIKppK5nInl+A7Gg/HP5Bot0bpcVtO0XrQ/Se6UPKnfVd8PuIL0dBU/d5A==
X-Received: by 2002:a05:6000:1fad:b0:382:4b9a:f51f with SMTP id ffacd0b85a97d-38254b18b6dmr6743750f8f.47.1732199339169;
        Thu, 21 Nov 2024 06:28:59 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45bdbabsm57394855e9.18.2024.11.21.06.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 06:28:58 -0800 (PST)
Message-ID: <15918318-8071-4c20-9e83-9b93a5410683@gmail.com>
Date: Thu, 21 Nov 2024 14:28:56 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git problem in windows server
To: Luis Heredia <luis.heredia@tool.es>, git@vger.kernel.org
References: <e020539e-b66b-4d4d-80da-9f51d4b66683@tool.es>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <e020539e-b66b-4d4d-80da-9f51d4b66683@tool.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luis

On 21/11/2024 10:24, Luis Heredia wrote:
> Good day,
> 
> I have a problem that i can not solve after a lot of checks.
> 
> In my windows server 2019 i created a bare repository (c:/gitServer/ 
> git.git). In that server i create a new directory and I can clone it 
> without any problem. The repository is good.
> 
> When I go to my local machine, i can start communication with ssh to the 
> server (cmd ssh ssh://user@serverIp:port). I can navigate to the path of 
> the repository (cd \gitServer\git ) and change anything (copy c: 
> \temp\temp.txt). With this i can be sure that the rights in the server 
> are correct.
> 
> The problem is when i try to clone in my windows 10 local machine (cmd 
> git clone - v ssh://user@serverIp:port/gitServer/git.git c:/temp) i 
> always receive the error "fatal: ´´/gitServer/git.git''  does not appear 
> to be a git repository".

I'm not a Windows expert but I think the problem is that git expects the 
server to run the command passed to it with a posix compatible shell but 
the default shell on windows is cmd.exe which uses different quoting 
rules that cause the command line to be mangled. The solution is either 
to set the shell used by ssh to bash.exe (see [1] for how to do this) or 
to use the --upload-pack argument to git clone to execute the command 
with bash by running

     git clone --upload-pack '"c:\Program Files\Git\bin\bash.exe" -c 
"git upload-pack \"$@\"" git-upload-pack' 
ssh://my.server/c:/gitServer/git.git

(Note I'm assuming that you're typing this in bash, if you're using 
cmd.exe you'll need to alter the quoting)

If you clone using --upload-pack you'll need to set 
remote.origin.uploadpack and remote.origin.receivepack to run the 
appropriate commands when you push and pull

     git config remote.origin.uploadpack '"c:\Program 
Files\Git\bin\bash.exe" -c "git upload-pack \"$@\"'
     git config remote.origin.receivepack '"c:\Program 
Files\Git\bin\bash.exe" -c "git receive-pack \"$@\"'

Best Wishes

Phillip

[1] 
https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh-server-configuration#configuring-the-default-shell-for-openssh-in-windows



> In server and local machine the version of git is 2.47.0.windows.2
> 
> Can anyone help me ?
> 
> Thanks
> 
> Luis
> 
> 

