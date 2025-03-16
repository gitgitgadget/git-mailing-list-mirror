Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A7D376
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 02:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742092670; cv=none; b=I4fPTqg1lUbZjyKx/0DFclQbatr1okYxXxfjOR4g0J8V44CIcPVMqFAJb5MTSoaTPUQsxtwo7Zq+mrqdf5tu1atlhTFterCIHHYOC/cxvm0XLTEZYXWbxPGh+BnWeXrtITdyFpxG6GKMgQkEnD8hYEd05swAgrJnaqr3hD1/khQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742092670; c=relaxed/simple;
	bh=r7RaZfDgkqCj4igKj1EXQ1CVjw2/MqCfLfFho/DB66U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AWHNwgD6eUcMPYxa02HCzhbqeCk/Kt7gVmLYCSXxEvwBe9EVq7G8vfhYP79vNp1CTrTqqPsVKp+IlhKNNO5iQGd2SF10Y57G5sM4pBSqxRMuDK8sDBCnlLV5sxplBV8WXrv91SMBZ3h8I6k8XKuRHDmAImoe2LlM4/fjLca0yjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=DyJNoP2v; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="DyJNoP2v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742092666; x=1742697466;
	i=johannes.schindelin@gmx.de;
	bh=PBOEugWlfkSCGUR7JAKlg8aHf39xKpoaNhzvaIm66R8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DyJNoP2vB1cmmxBJC9MJA7EfT0bD+FPDYi1SP25xPQglCWmGjQDbVwmEbEYFknJH
	 v8KvX8uGq/6tzv/Wj63s9JxgQSbdY6+zxwXdQjStGp+kXvx2/SU1qml1+ELjeCoKX
	 6Jed6TyThnDIb6BZrTB7zRB5Y6uEkN3bihRnq4Dh1IT8daBHEnAQ/QQc9BLJ6KqAs
	 vj8fbeNAvOvxvdkJGkT7pAGUKbbPqUHWsrRZJUxvfW4t1Ce3pAZeK4rLbvtq6adSt
	 l3oMAHg//nLSu0xy7KAk8qTvuiuIeARnNXfGkhqqyfPM9qo6ENnH42EfaAKBLA6M6
	 G55JEyJBSo8uQEZCXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.73]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0XD2-1sxXW13Vcy-00zyfi; Sun, 16
 Mar 2025 03:37:45 +0100
Date: Sun, 16 Mar 2025 03:37:45 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Zejun Zhao <jelly.zhao.42@gmail.com>
cc: git@vger.kernel.org
Subject: Re: [PATCH] contrib/vscode: respect configurable options of
 IntelliSense
In-Reply-To: <20250204125721.11357-1-jelly.zhao.42@gmail.com>
Message-ID: <fdd8e2c6-9adc-4e53-d65c-ba75da0758f9@gmx.de>
References: <20250204125721.11357-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/iyLwJ1UveCbbxxuxVUgKnzjE0qw2xzkxIzcuKKD9mbfXwvMQev
 A4aLieN8/Jrqb9rkXg9V057XgZzF7XEqFfeagDQTNWPL+pwTv04WCKqSFqAM54ZviIVkERR
 JV3u75LpADm8Wv0sj5CeTAUGQhduyshnkQb3IZKu3LsnJWRLaj8ZQuWu0+ehlV9R/gBzh7j
 s/gdIuopXBDCz+EbNq6GQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PCrDE29D0lw=;y9jQWnjb+kLdWsruwr34wILcfkG
 IvlQhshE1N2k1I1rum6de65VEg/L2zsAmr+m5gs1BxhPst+e6UVTOAUPMd/70JIlMHVD1HAW+
 UM+lIkTXuq4Dvbf5G+xJ/P0LH3bjF+r9XPHNA/Rl9IrMOkhpbWKl0sfE+je8xsYOS08foKqif
 9vJcWh0Q63yOytgOSS3XG7NUEHnsnGed8Yxk+oPjbOiQgrVlv+dtQ5AiogdGggKsmvdLT/Yt7
 +HxTMOfqbZKsFb1/WmO0V01DBgPPAcsaN0yOU3uqNbGTenWjSTsj7KQLWSqqU73GMwZhRxMlR
 qz1AiVHBKIW4we5cvArXsqHRDN/CwHOYqYQgEkMCzPmrai/C+VYiHlAsr/3IfDoMQP9IBwNqU
 FQ1OslpgZhGkdkuEdS+0H2tWYwOHljCXO15Y48HLDHOyH6oIJFhfakcnKkD6ITDDhJcON5AcO
 3Q1kEs3YldMBrLPO9VmK63+trubq+cKCtsZE5L9XB9d1H9p3QSt2qAlAQ7vcrAqxRkNJ1X3H+
 WBGqOk+39Xp6f/1dPMfa2vib0lzMEvYLvHmqgZxdkMAH/D4tD5keXTNnGXp5CHo0L9gy9sI83
 bOY3Bmraa3Y+emFypFCBzRVK0w5w5ceUsKATUIBdh9t9p0fGIH4LYLWFWJyTLdCMVWUZQBUya
 jVxQpIbHIZ2ulNcONIsngrItvvnbKrCQp3dK1FvshG7ZwOuH4cDR9Ayu7heynEvhFVvkMi332
 1GjaqZ6N5lWBxKB33lm8njUQsa48KEnEGvZFzVlZyVz/i6aIPS5YsnKSaX9ffmSTK7T+SF94M
 Tq8Sbl/GpFOOqaRPsstPE6lqDQx42SWWkYmMDSegX6/YrPcrp0eeGaAoGhjFO6Za6z4F24IKj
 wgeggaV80HbA+yHlEheA9nHl+znd3MPIc0NoDbwzlmQ2jEUwtkEoSrKxU6+s/HZ9GRbXo0yH4
 2r88ER2IQ4JH37apeVQpqc+wFK1MvePxHxj7aQehsZITytQAY+v+BhWT13LJnDCyyuFwmkhT3
 F1/o9HNMhc2GyIPwBF/dr0bLbfLbCPk7MGhwPLBssZQmvbxpBcLbhcVblOE68NA/8HKOFNrer
 +8yyAtNHEdVL6fL4JEvpZA1jRd62EtRu/r18kb1/2yjW01tOHCuac0DgSsYmlOONh4/aTtHpB
 PyxWpnQfcFzaipAspsTb8iSK89unQorunUc+0/4ICrAMPZKKhQ69UwzmNTnSD7dIVvyv0djph
 l3/ZocuTKYPQlk7tiO/LCWDoaJ7cTqhI6LGQoP7rW9/AfIkj98NujsKQH3YV5QMUOfTKSg74N
 7xHEaTP/zH1sd5+hI9PEFUzW60SmPh6gzTO1YBUu3Esy1xtOYpUijDD62Js0xL66E+sVU2e5q
 z2RyOelXHc8RW4dBCJ000GIAS470kzn5V40siIlCqNjBHKX0ca5KGxWmyZjEpIYVr2i5zgdDj
 lLpNV1+b/80Isat+5DupUFQwavZ//3cXjP5mKvhjBEq4WRU35
Content-Transfer-Encoding: quoted-printable

Hi Zejun,

On Tue, 4 Feb 2025, Zejun Zhao wrote:

> The initialization script of VSCode development environment uses removed=
 configurable options of IntelliSense, e.g. C_Cpp.intelliSenseEngineFallba=
ck and therefore triggers some warnings.
>
> Fix this by strictly respecting the latest configuration manual of VSCod=
e IntelliSense.
>
> Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
> ---
>  contrib/vscode/init.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
> index f2d61bb0e6..17f5b6161e 100755
> --- a/contrib/vscode/init.sh
> +++ b/contrib/vscode/init.sh
> @@ -15,8 +15,7 @@ die "Could not create .vscode/"
>
>  cat >.vscode/settings.json.new <<\EOF ||
>  {
> -    "C_Cpp.intelliSenseEngine": "Default",
> -    "C_Cpp.intelliSenseEngineFallback": "Disabled",
> +    "C_Cpp.intelliSenseEngine": "default",

This looks good to me!

Thank you,
Johannes

>      "[git-commit]": {
>          "editor.wordWrap": "wordWrapColumn",
>          "editor.wordWrapColumn": 72
> @@ -203,8 +202,8 @@ cat >.vscode/settings.json.new <<\EOF ||
>          "\\Wchar *\\*\\W*utfs\\W",
>          "cURL's",
>          "nedmalloc'ed",
> -        "ntifs\\.h",
> -    ],
> +        "ntifs\\.h"
> +    ]
>  }
>  EOF
>  die "Could not write settings.json"
>
> base-commit: f93ff170b93a1782659637824b25923245ac9dd1
> --
> 2.43.0
>
>
>
