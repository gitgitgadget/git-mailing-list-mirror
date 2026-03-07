Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA17C2727FA
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843372; cv=pass; b=fapIc4qsrJTcD9AP13QL1+yWU+Cs5Xj5nxrDOMabuKRe727BCTkEkLaeJrKW7l4i2GvZnJF7O+TVeqEN6zuJFmuQbCl12MhOjLtLy2tnWjuVUEuLRRTRc4bNz7T15hfS97EbqTRjZDUlAAiJrI7yaOfVBF5rw4iAXV/2wcX0Rb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843372; c=relaxed/simple;
	bh=WJf6e1Dnyj1c8a9Wd/mVo5XjpX/H8tEPEqzaWM9CZqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uwJOjl+P3cmBn5OS76BLxs2huJkTc7LVOqhUzuBlBk5gCXkbKdvSRoG8B/IbaPCW7gcmqYHTTanBjVYaF16cCB2wbVCic9i7Hngtw61B5Yi62CwIVlWuzoreYowv20tzs36routgAqP5o0j/tPZsAhhnYFOHHDyRVQSgNbqUrks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2bTZo71; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2bTZo71"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c737d3a51bdso1379629a12.3
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 16:29:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772843370; cv=none;
        d=google.com; s=arc-20240605;
        b=fIuqrbOV47KGUayeb9f/r50d8J7QcWmY4IJ1EW6HZL+E753Oazp4g86Bi95g+UVwE8
         WMhAFmw/wzuRXDwdURt+ul+ea1YOdBMbaahvmwL2EmoVwGsLfqN7+vNHXbBJ78b77Aha
         02T/cySX07xpfUpL/Lg54r8Z6wT7hwC/HII7X49LVH3OhWoImPYA/I3SNy9O6cipeuIX
         TAvTduyoKLBios7yH1SACQdP44j3BAN7m4hHwOCtrtHNgvv+W5JIRQ98oWRu/JqeyYm6
         HWnSRF2IFDHu8FpCav/idW3XymvB0U65evUGQPURD3AW/PToXwfWTFb4Ch7ryFGhV0jY
         DCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HoH7yvJDwgKdMYg1UwuYBjnDuSLVY5VZEzKY+KeRdSs=;
        fh=hjpzcGvIl1b1FEAiIn4nEIn4B39AdYiIEEhEDYfpSFA=;
        b=QX/maJdB1AI3/vt+L++Yc6YTa2qPqgB8/WEyAz65DrS7mvt8lUB/GaPPMMcRGOWK+/
         ckJg+mkgntfbWoC1JWKkqEikPjEEOvegTacrNVQ8ajawP4Yu+CCmFENlpvAJeg69ppoz
         PnlNg4P4lr5+W1StlbgZd+XxDzof/tFxLT36UIOPZ1pmai7CkEXoTtGEFAToBc9OjxOB
         GoCfqbQEHurkd+ATTd6mIfuGY6/J9Arj1jeO/Y5b1dDGShpdvjyrfk7NqF6k81GVPhC6
         RodneuuX+Q8nVXLRgsEVIs4vxhTeFSmzDIH3c0HJgKYRF4j0S6c3BuacjN2A7okxd0Zh
         AGaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772843370; x=1773448170; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoH7yvJDwgKdMYg1UwuYBjnDuSLVY5VZEzKY+KeRdSs=;
        b=Y2bTZo71eBHSBU0emdMS5w11m9NCg1ZqLlBh2m32/QQL9NVeK/0lKNgobAYPDBXOQa
         dqYjG/QZ0ugDoVy59MaGOh2RLfUM3k45Exm7+QdjyxQL+kjSFDl9jZoYBw9P90GukSr5
         0mHGWAsjFOim24qgYiZINIwl0oZO4Ac4Ag4ECrpQp+cYuOvXEleWX44UWnv0n2vT5y5h
         LfE4jK2Juw7MhgzdtLITg5nul86UV1irm5V56ajjrFcpF3PsEf6bkYIeU1fWHeJhX3RV
         fF5JKjr/JAoi2hnXOh634XiRnpmR+cx258kyFptzxNI5n2HPsRDAXwGwQHdPZNFbcvNY
         fJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772843370; x=1773448170;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HoH7yvJDwgKdMYg1UwuYBjnDuSLVY5VZEzKY+KeRdSs=;
        b=Fd4+gyYL7WzoPJLNCeOnEw9gu7w7fPfcaKrwx9HPt57ngyUGGz+gqt1NbsQwbybP6E
         V/YEWMbqaX3MdGihuO/rJy8qYjLZtE5vrux2+jdTUXLdkRsjVfSdCcgz3bhebpP3RaHp
         ZcyvIprPDzaV9xNvZUy8CrOppZStQTVpdEH5xFtyX7hglRV1nEbopkNATB0dJUBVZpX6
         HU8DA3I8/XKVH62NvOz2gS62TKBV1L93PvPs+LP6kK92dkDDWI4kbMILV1kvZ7Ds1HJh
         LzpucMc0YoZyNGDDqZ3GemQY5MwIMZ5azglYK2mZYsnGs6ZyPE+rhFcDiiiBYdma+GVe
         E3fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsDRt8N9vnbW4uxkzUSsFO3zdtqC8DdXgwTLziDjBeprFZYfwgFsOnvi2IDNwnwh/Onf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfXlMdJdSHxaFPYy+6V3++e+nupUHPpzAVy8UlcQEJ1cTaUF4X
	t0gbtrlmQoOtlojcrEoQpUMMgIRhDnfMloVc8ciXVTpSaintXb+ZHIORwFsNVEF5Xtb+K2NeanS
	NS0s9gObkXnM/EIi9znZbHQ+YpK/Af3v3dlVJKEPPlQ==
X-Gm-Gg: ATEYQzxV9wtZ3PgUR2ly6ASdLflZZh+2jsM+2hfOMY2boY2e6b8r0053Oo/ggDgvnDW
	Wohy38OmGvoyfMF1rW9PUFLk5UopB39qS+uuCbwCROPlg7gIZvaDltYZPDajyk7ROfXnBNeDGZQ
	f1bVjupyi1fsZKAkEwL3MAxW4LD2iiy/g+Hw0opNW+Ggr5p7nxLCTT/47bkF8dvchIU9vXcyic7
	pYFP57tjSPy2w7YdCsrkYPHCCF9PA01uHm/Q/dSUMS1LqhvYt2GI+n/13m7rLE2vUvED4GqTxup
	eeNuW97mo2sExubz3/VxOVKF5x2kg/d/TPU9EoSAIHKBT2kRJRvKki5rHa9Dx5WK+RJ4
X-Received: by 2002:a05:6a21:3948:b0:371:5a31:e477 with SMTP id
 adf61e73a8af0-39858fdf06cmr3821092637.25.1772843370177; Fri, 06 Mar 2026
 16:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7947msLiGgrYTcg1m3ew+bP0F+VNbRaTy=ZW7zkkHh69bN0Q@mail.gmail.com>
 <aatjasMiPIeT0s27@fruit.crustytoothpaste.net>
In-Reply-To: <aatjasMiPIeT0s27@fruit.crustytoothpaste.net>
From: Mike Banon <mikebdp2@gmail.com>
Date: Sat, 7 Mar 2026 03:29:18 +0300
X-Gm-Features: AaiRm50NOuXxdz6QPbYuozHlOd80m1u-kGDsnUQypHh1WbZRwinMjYRKaBBMixg
Message-ID: <CAK7947n9gqhRoykNUR4NvPFiaCB4nuotxQTT=eftSF8O9ZO2rg@mail.gmail.com>
Subject: Re: [PATCH] clone, progress: add --no-turtle-speed option to abort
 slow clones
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Mike Banon <mikebdp2@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Brian, thank you very much for your code review!

This problem has been happening to me for a couple of weeks while
using GitHub: as a part of my "floppinux-amd64net" pet project (2.88
MB Linux floppy image with Ethernet/WiFi =E2=80=93 for putting into a coreb=
oot
BIOS image), I wrote a large [1] script that clones a lot of GitHub
repositories and builds everything from scratch. With some non-zero
probability (floating between 5%=E2=80=9330% depending on day/location and
other unknown factors), my git clone operation gets directed to a
really slow Git server with around ~70 KiB/s download speed, which is
especially painful if it tries to clone some large repo like a
linux-firmware. But if I terminate that git clone and start it again,
there is a good chance that my next connection will be fast (at least
a few MiB/s). So with the bash code like [2] below =E2=80=93 in case of a s=
low
connection, it will simply restart until it gets a fast server and
clones successfully.

I agree that more customization ability would be useful and support
your opinion about the turtles, so your "--min-speed=3D128KiB"
suggestion sounds great and I may try to implement it in the near
future. At the moment I simply wanted to know if such a feature,
initially created for my personal needs, would be welcome upstream. It
is unknown how many people are affected by such problems, i.e. I've
never had this annoying problem until recently.

My reason for using the environmental variable is simple: not being
familiar with the git codebase, this "variable solution" is the most
minimalistic diff I've been able to come up with (just 40 non-dense
lines) that is still working in practice. Another way was adding some
"speed_check" flag variable (either to a "progress" data structure or
as some "extern"ally-exposed variable), but I ran into some problems
with this approach and just did what was more reachable to me as a
newbie here.

Best regards, Mike Banon
Open Source Community Manager of 3mdeb - https://3mdeb.com/

[1] https://github.com/mikebdp2/floppinux-amd64net/blob/main/floppinux-amd6=
4net.sh

[2]
# Formatting
   bold=3D"\033[1m"
   bred=3D"\033[1;31m"
 bgreen=3D"\033[1;32m"
byellow=3D"\033[1;33m"
   bend=3D"\033[0m"
# Prints the status message in '$1: $2' format with a green color
highlighting of a '$1'.
printgr () {
    printf "${bgreen}$1${bend}: $2\n"
    return 0
}
# Git clones a '$1' repository from a '$2' URL, with a '$3' branch if speci=
fied.
git_cloner () {
    if git clone --no-turtle-speed --depth=3D1 ${3:+--branch $3} "$2" &&
[ -d "$1/.git/" ] ; then
        return 0
    else
        rm -rf "$1"
        printf "\n${byellow}WARNING${bend}: cannot download a
${byellow}$1${bend} repository !"
        printf "\n         Please check your Internet connection and
try again.\n"
        sleep 1
        return 1
    fi
}
# linux-firmware needed for some Ethernet/WiFi network adapters
firmware_get () {
    printgr "LINUX-FIRMWARE" "remove the old directory if it exists"
    rm -rf ./linux-firmware/
    printgr "LINUX-FIRMWARE" "git clone a repository"
    while true; do
        git_cloner "./linux-firmware"
"https://github.com/mikebdp2/linux-firmware.git" && break
    done
    return 0
}
