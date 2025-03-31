Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BD1A7046
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421608; cv=none; b=EFUGFaAvJDuWgJiu/skNrhGiVqny7rZ8J3pC9rzsvAPZK5bNQw41BYCADlTJ20K1sbaMmVfOTlkBJ/AHTDsoptgp03/T1ZNMRBnB6zbeELB0PPz8EyPqiG2zBNlBxQCgNrEVfus6IiZICwmQo1BWorGXWWmSTWvw6cMBGJXhP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421608; c=relaxed/simple;
	bh=Byyr1ey7DBJn3DdX+y0IWWyM5AzVHIoQb4ftax97v6A=;
	h=Message-ID:Content-Type:MIME-Version:Subject:To:From:Date; b=aQSREjqLWlx2TJ7yDlMG0OycffnaJCYrx071vJLkwRpLbp5N4OWtAVRyzA8CrfpN8o0mP/D9fNwT68FhfSQvqcUg/yims+eUasoiDrYmwUH7BTjQ/oD5v0/KWehodu6Vkk8y1au3hE7Dt+PBshANSKhna3ynjPKzw1CUJ+nkClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GopXVMaj; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GopXVMaj"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-22401f4d35aso84584175ad.2
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 04:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743421606; x=1744026406; darn=vger.kernel.org;
        h=reply-to:date:from:to:subject:mime-version:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEvbH4sMt09+6cSeAQLzCC1D2IP2TEb5fvqoWCzpByo=;
        b=GopXVMaj6+LpoUlJrLSvH9P4oczHVbSojansRRRGDiCr8MFq93Gl3YFWGe0zRmOq6d
         9yQUvqs8dCBgA9ECUcxccMeBesvwe0SIu9R0vShv2awq2cSEym0MkJEYYeBuMh3ZSOpj
         ZQ6z7Slp6uYYEiG6+KcfApk2kvdkOjD6tqN6nioBFyLLf/QypbNZfDqI7pO1eGPZQUxk
         43RVFl5HuEhI3SQLApKh10HTJ7OyeOd1eHUptQc+tQI4VcwGcQJK/VVzcrV7Pad83eBh
         MMfplVk1vuqQuUIQMrycDR/x7kLmS0vMNO9gV5yvaeHx8k841xYMe7BF0cNJOngpbG8/
         Rk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743421606; x=1744026406;
        h=reply-to:date:from:to:subject:mime-version:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEvbH4sMt09+6cSeAQLzCC1D2IP2TEb5fvqoWCzpByo=;
        b=fu+JJVQG5lxXUJU6ACuLSgdd19lyu+NuQEVo/d4QZbgDA11C794g9mo+f/njjBZXjB
         j2a0tD+LNt9aj4JyfPvw8vL5dSpJlYeK3chA5SVF7VyP/tPI7yPMiJK6F3C6dD5xrQpx
         HJ1eMOoMn3OggcbgVxi/9gdjG8c9QhR12u0QxljjtfCKKbd1igadnt3lydWZ/stUnzHt
         zbjGDSjc0eZZ8l/Dnr3IkFOJZG0fdidMrvsZMR4ZUQG6Q4VcE85cD9KCfJnrkAoTYN8X
         NQedySAVBtzSb6+0aCNO0hELiMVaMPlfIhY+Y0IYqhLLBDP2DjIRb9PFAjUdAttJS5nX
         +gxA==
X-Gm-Message-State: AOJu0YxM73VVYSYL5BNbjULYQ5QWzGL3zORXeCiectrHm0L4VUGzOjC9
	mKuPC/OIErqRzncIFJ4Ar3dPROw30POSM2zj75m7BnUCZ4FeK46UT3pnowO/fZs=
X-Gm-Gg: ASbGncv8XUqzcWnpMX98ih1BWdHsiNS2950MxPZm7+HNxWaTZECcntp9WpnpH3OW/X7
	oiWZXyuIlCmT2XWGeOvQX1OZVmOzYEXRlnwDhm47b6F0rQywc1ldp6zoma+fmZ0QsUkys9jMDSd
	pWw1D3KIX9Am2Ps+HwaVzADECUt4tmUM5iDfE0ilAzGM7/YAqZjSNPovDj5VrmD2V42T2nOqsoi
	Oy68SufKJL8AP7Z4Nv+c4BIURLZ/VDJCABFN3j08qxJDpr7qa8xeWrbvrhSw+Vf7tsGHKF+amLB
	jXpUo2Z49e7KCyK8cZ+9tknFv653n9nYdeaJaKUm89AbyvyQVrDC0SDFw8B8JlMfOBsI
X-Google-Smtp-Source: AGHT+IHcjDuzca0cPQEuUCM38rj6xKE+eW27O0a82mxLXjlB9ZMTpU3zRjE2EDplDmnNQg+SVtTHWw==
X-Received: by 2002:a17:902:ce89:b0:223:4d7e:e52c with SMTP id d9443c01a7336-2292f944d1bmr145822195ad.5.1743421606503;
        Mon, 31 Mar 2025 04:46:46 -0700 (PDT)
Received: from Oshiorheme.lan ([197.185.141.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eede9fbsm67334635ad.63.2025.03.31.04.46.44
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 31 Mar 2025 04:46:45 -0700 (PDT)
Message-ID: <67ea80a5.170a0220.3dac99.90ba@mx.google.com>
Content-Type: multipart/mixed; boundary="===============1061606141=="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Fw: Apply now With RCS GROUP
To: git@vger.kernel.org
From: RCS GROUP FSP 44481 RCS <thulasnxesi.anc@gmail.com>
Date: Mon, 31 Mar 2025 13:46:42 +0200
Reply-To: rcs.co.za@email.com
X-Antivirus: Avast (VPS 250331-2, 31/3/2025), Outbound message
X-Antivirus-Status: Clean

You will not see this in a MIME-aware mail reader.
--===============1061606141==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body

Attn;

Whether you want to give your lifestyle a boost or have an unexpected expen=
se to deal with, a Loan from RCS is the cost-effective way of making it hap=
pen.

RCS Loan @5% Interest Rates, Contact Us Today For An Application Form, Acc =
Balance/Settlement quote & Paymemt details, Whats-app: (+27) 082 596 0415, =
Call: 087 5100 651,   Application form Email; rcs.co.za@email.com

The special offer is also open to blacklisted individuals and debt reviews.=


 RCS GROUP
 NCRCP 38. FSP 44481.
         


-- 
This email has been checked for viruses by Avast antivirus software.
www.avast.com
--===============1061606141==
Content-Type: image/png
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="rcslogo.png"

iVBORw0KGgoAAAANSUhEUgAAAWsAAACLCAMAAACQq0h8AAAA21BMVEX////xTiQAAAAAlXfxSx7w
PADxRxX//Pv95d/xTCH+6uXwQAD1jnnzZ0nxRhTwQw32lIAAkHDW7umt2M5yu6nzZkTZ2dn+9fT3
9/f4rp/Y2Njt7e35uawmJiZISEiZmZn1hW1/f3/6xLnCwsLPz8/zc1f84Nr3ppZpaWmioqLn5+f3
n4382ND0d1vzbE/4s6U+Pj6Li4v7z8b0fmXyVi7yWzatra1iYmJTU1PExMR1dXUXFxc1NTX70Mf2
mocjIyMSEhJcs57I5d6cz8I6pIuOybpouKVFrJTR6uTpIOOoAAASiUlEQVR4nO2de2OavNvHgRtQ
wIJdp2irrbp6qMfVQw+2td3W7f69/1f0JEEhQBISxPW2D98/tlYhhA8XV64kV1JJ2kuF+WiykuXV
oj/fr6BcCSqWLctWDVk2VFuTZ4WPrs8n1siy5UCGtWp8dI0+q9ypI4elWqWPrtTnlLnS5Zic7kdX
6zPKXapx1LJsT3OnnblaNgk1gN11P7pqn00djYwaws4tO1vBQC+H/VfUsKiooc/+6Op9KlWIDWPe
QB5ARUK4lzeQh1GH5UIQ7Elu2RlpRAn4cMvOYWejcoIPQbA/upKfRK1k1nkDmZF4WOc+OxtxsZad
HHYG4mOdj/plIZ+1oRr0znreQGahLWvVWU5XKiv+c/LQb195rPUKnM81Rw7DtI/EZxfMl0a/1K1U
TrqT1qjTE+z2Ftxeo7/ZbMqbfh2cnOktI9ZqZVsmcyAqM9juuFMflWka9Rs9M2XJZqdUsSzH1lUk
3Xa05aI/5q7YvDzVNQecr+u27ViaOi130tYlLsTaKu5+bVAHs+XMGsj+EuGgCd6kPO33xAueL2RL
jw6lGartVEbF5LOlcWvppRLgJ+uWMelkNCQEWeut4Hcm7EwayI3GaoMxQGJpKoXZ0tEpJYPSFknP
bjy1yKcbqqOXMzFuyNqpYx80LJbP3r+BLNjJqD1AWoX75ZekmcNqa4A9aROWbZsLjTG2bNhaKQPa
CzXCWmoctoFMGsQN0S5zXu2lwrKQLW1rQ/UFczWpVrbT39eTFCpGlPWBG0gB1uBqFR5zKpRZRomV
tnwhF1DncWvOinI2r+YwCSfC+rANpBBrWV8m+5HxKppJRJPq9EkF1JPG8LdnW6N9btxcwgcaZZ0A
e7LPFQVZy6qe1Kg1LC6j9mQt4gUQpksMg9iJdqap/Uih4UVIMdYJDeRebkSQtawa7PvbxOwCBDEW
jLBtKxrCAdmVaHFm+BhVdxxVXi5V1YoHkPoyIXh0O6MW6EfFZWyJxlknNJCLPWBjrFVifK0BQqH7
O2EVV4oYJSAMs5p7vWKxN+6MJiBkDt+JXolUfoE/fN2qlDrjoum6ZnHcKU9tR40Uz3rNeiXV2vWj
ItpVgsD6cA1kwNoamyT1OqOTkFuwCNXbqRR21SBO7Id75e64rIbtRgu3AD3svVCtUi98Z2aja4Ve
RJueU2q27OR4lsT6YD47YK1RY4zCeII5MUOnHjgKWYSqTV4IRuDOllhpViTlBRtUtisko+2VsCjH
0Dq0uoz1xKlbGutDweZhLcEGK7hBqi2F0uMMa0p9v2eOd1XQKYnEEoWgCOrsU7G7fVaGs6R2ZjvJ
ET6d9YEaSE7WoMkKYDvkFgl//UE8N2OU5rYsVdUtOdadmftvhrqi31FH1Q1DtZb0S3CiprE+TAPJ
y1oyg+EJclhcwHOZ7VVChDDvnrQIg0h93+FbrK6K2VWXkwbjYbBHCDBstAUb7AYyHWxu1ljcq0Zj
B6SSjVcmOfIlVrfkz0vJ7LNN1gV4rRo8UaoTOoDP5meNRWOkQ1+wECR9FNrdvRtqK2UJkghq1k1n
D1uA9dg3bIIvLmBJnzahN8ip6a4UvZy6DAHU5Dd0K3YDmcKcBFgHObR2fCQC82/qSrgWvgLWrbRF
cPtq8o1gyrqBFGHtO1M19gYVVn61DHWPseUgj2CZsgQR1LLObsEzbiBFWDd2LlmN9dOxASNrn7WY
fb+B1VLMukkwaBRB3Uooje2zk86OSoS1H/waMS8ReGs9vbOWQsFOqsFiIdSGk2xeLNia4Ah6NqzH
QZWcdPa4lYv1G1vipws0i/COWd2trVgNpC64wFeEdd33IdF1O0Eqs+j1o8LCGacr6vjnIr5atrhC
nRm9zBiGBImw9huumJ8Lxpwp/Xdu4TMFui42qSiImtMqZtQGMh4isCXA2vVjDTvSSQ8ib9HLx1RY
YT19w1nW+WkL+Wo1OupFF9VnM4d8CBJg3QnGKiIjmX3qN+Kah+4M0N5wNgAvAqhVS2RmeEaea1Yd
waCPnzXWM7Qixub3rGVt/7y3TfidNWxn2uEo1XMghkGchglJd0CJQlVqWHa8GGcpGgXwsw6MN+oo
go5MukAtokV8Rw+rRJp1wDW3DTjhtlxVTtiaLkoN4VCpV+rGyhkJTyxzs8YmAqK9laJv1lFHnk6L
eGuka8vNmIG75xiqdjIau24hQWkrlUE5vKyxyNVYRp5o0DTShyiFVCY4SMO2KvQMzoamdfcK7P+G
+Fi7JSycis1lBHFactzIp45DSqVQHbtLmyCoH8EOZDys3b6BzQMYy+jt+n0cWbRlpsptkfPUVEcf
ZZeB/ZdFYl2YN2aBRhUtNPevxSzIHzAy5OwS/8dTcgIVTFL9z3sLsgisiyvNwRROxZGdeHfLt2uD
MR8rrvnEInkSmKHTOkrbjrMuTFlpZzphDGB2GNbAtkuUNG7dFo+4Pl5x1i+sAXJ9RbhHf1w7Sx/i
ya2vNNL6AsNZ/VcaQ/4lJXHWG0a+EDkzNIhD7AOsTYPGTcCtaulnJDNUZ6lxj/bFWU+pOb0GZWhs
nHnMF1ahs5Ct+D5Ye6QEZyO3119ZhsM9ORJjXVhShnAMZ0kZRej5b0JGfZm4zM5Cd6JGYBOWOZj1
cimscl3cAIrz+qaUoMV0CQM0/SS9D3EpG6kZKnV9iymzUmyzkjk70SKtth6z7L7uxLKaHVts7LMw
q+isVYhbeYnFxAaMojhryko5lWGy/gigutdkY6LGpXCoH8tE6RNHPw3+sWqgmRx7gejSY7n6DMV9
SAVG1+C5RuzbUOlLZYJEXkvgptLIHTkh2uFkcJM2McMP21yJzDjY/A5EIrWN7gvQHK4BCA9KqDLV
7zWCuYKDR2LuJtS50vCbpedz8MIex9aJMFGLtc6M8RB33rJDCyqoCVlFn3X6dCV+FbvYALeNR359
+go0Ptg9VQS1QLPoVZw59lRs4W+UTZ1MDGKX5JSLDIRN3Rgqdr8Nxmo/nhV67koItUCziJQ0ztcx
sMs7tO5DsNWdvRG7fjqNAqgOFoiarC4vB2zaFs1k1CLNIlLimKpbwfyIRZl3KfqTNntl8/ErmOEM
ea0+C3aiGxmzkpz2R80zfo2PRWmUZL2gs8lYmZWhgvUi4dzCFmvNcBLsroAHEfXVUBys8ZQNgxJo
4LORf2VQyJ9OjszI7QG7KGDWKayac15GxmCTF0ljCQ1qdDryIAoWexjhesdm4XExfXaf31sLN4tI
XPONRSwUoiySxnLDSEPcmStojdVIVhvTslmwT7hdSDrUnHO7Y6zjrpIvhNWUHhtmJ5+1sYzWO60b
YeyoH0GdwldDceYs4GmJ5EWe40zWJnEr8CFxl5UOtsm7C0Ja1Nz5IXgCIWHKEagcgp1YnYJJv55p
Jj4r/0WLr3FIgk2LWznddapm0bsCb95THYNN9HqhDFO7kpAb3KnoRndGqrVZn6pOJSHhrsEeFWA3
kGTYnKztdL4aXYE7nw/PabRII8LhNdI6c9lM2VLhjmTyJmrAZkl3gONUrRbrlrCBX4f4VNgNJBE2
F2vDymRPi8T5K3zDiniSiBRb+0/f96wjb+/LcCIjtXV/gFq369S7cvHFlORqi7sRDtaGbQimXIev
ILCuYBHUxnBIIKN7WhB34St0KtiIvhFa74XvqmM4BiXR/QVb+U5dCiXcQCawhvswqpu9BiBEWOOZ
I6pMcsjl8A3qWrcRbubc8WgZzmfCdwCJ/Ck0w7FL8yjuwniBjz3Sl+aJWnbRf9c0gizjpNTYc6hH
hHVozJEcZke3e1Idu9Lqv/SKZrE3nvcXq/geRHgx0S2MDN2SJ/15z1vpX3B7nXIllAzFWiwm2EBu
WdvLWdElaf8wVoh1aBcR8sZP8b21VN2xbB2+gqS9tSKx6ig2YQi35tLlJdwQa7XUI/trGcydvsQa
SI/1IYfOxFjDnPKAE7F7OKOkPJJvOFYEORvYW5oR2zjOYG4yIuhGEGu1wgEhrQRZSy94IjZx6mC8
4h3DIe6FaE64J1cNcryHSQQ2Yr3/2iqGRFmHFiCStzRzS1x7fBrOihwUNmS+jStVOxkM02eHYSPW
2iHHKIVZhzuQ5Ludc0z86w411dTdWByvhrPiScPmbyA91nwM0skMNjbgjWjK2MyqRTbNQj1xT2Zm
CrVZ1hLW4OparMtJFrcbQXvZHpS1dLIzbP68R2xy3YguddypUJcd2iCl6jiJ+1e7fZmy2biM1ikt
uNdi88KG22EfmLW5tNA2mLqAq9ro/t6ZtAlIoM5EJe2h7+jTGddjnZdWVvx5wRhwtRFZ9c4H21uV
fFjWktspTabT6UKkBTYbm9YCnDSd9Flvstlpneja7m9D6CDQ1paLGT8ndwx7PyiPEZ1vO44mT0as
hY4ksRtIzxfNvJfowKyh0q2N5DmrYI5no9KiW5kuWuW68N88AbzNl8aoXF4swPmbeqeYJlBgwraX
rVFptW0e/gLrw+tj/xgOE7ah237L8ClYf7CYPhv3KB9d0c8gTtg56yzEdCM562zFBTtnnY14YDsf
XcnPomSfnXq3y1xRJVr23luD5fKVBPuQawb/3ykBdspNXHMRxYQtupFkLrZYsPfa4jhXXHTYuVln
LipsYi5Xrr00IcPW8iDkACJaNt8WzblEtYnN8+/5lzdz0dWRQ/P0hlXZ8y/K5qLLHTl+Mpzq6PRc
71wZyO0stvm+08YRbkB3dCqOx+Oj3Fbx4Pry5ytRf35+dM0+n76cUnT20TX7fPpy+k9Ip9vfc9bZ
K8L6x9mvf08h75x19oqwPv3nTKp9/fEjZ30AhVmf/vPjV02Sau856wMoxPr999nZL/Dhz9MjY12t
Vs/Pz4foR/Tf+fn202p126O6OIe/DLc/X6D/z+EBQ++T3Qnn1ZoUOkh6bK9vv9X8a11c31zdXQ/R
0dXhcPdFbVd4rVbz/gOHwiMu/DN91qdey3j663/vX86OjfW9onx/U5Qr8OOrotSkC/iP9F2Ber5G
h3xTFHCE0oY/D5RL9Bn6XnkAjO7gCTXwCzjnyTvhQRlI3sFQ1d2lrp7Q7zeS9Ix+aF5+gx/fNLcl
1S6bz+D3x6fmULpCR1w+bk/1Wf/+iUKQ9x8A99GxbisP4PYUZYgItKXaK2R9CYjU2oqCDgGsL6Rr
BAk8CQXZIHw6tXvluQC/Bayb8Ntb7wQIHprktfJWk6rtHWvwVJ+rtcfBBSxeaX8DRyuPsALKt+p3
WCws3LtcFbBuglMV5dw7F7F+P4Nm//P31sK//jlK1hIieA/Mt1po7lhLwy1XxBqAXAMbBDhu4Wdv
8E2oQszXAes75Ql+B23yyjtvGFwI2L+yG+YBrO/QJ2t4+h16hs0Ya/im3XoneHZ9+kWq/f76dQv7
36OLr9vKfeHuErG5V26U79Lr04711dauHyHN4Ss85vn5DhorfAfu4AHNAoDV9FgPr5qvyIe8Nu8Q
qQvglHyrhmZ9tfvZY30F36OB9w48ABOOsb54g4dBIdanP89+/jw9PcXayWNjvQb21YSQ7pWLB+Xu
AfADML4Pmsqb5y6B+d4DFgNow1fgFYBe9ln5Bp4QPG3H+g4ccg8fwyM46A16B2kImCprrwkEvgmd
OKyCFhSyvl4DnzKUnpTvNVQN5a4WYv101d5+J21Z//l9+vVrJNA+MtaD2sUj8pz3ynCovD57dv1w
e/W4vVHgd9u3N9BA18q34T1yOk3wkwfvWnn17Pri4gq1qwPlcXsQ+PIe+gmkZ2TLEPM1Yg2eMDzm
VXnesv4Wtuu3h4f13S5UQaz/jXTUj5D1vbR1xg/AvcIGa+dDdkKtH1TNiz6gF4YtZVuBYQPmr5Fn
GW4P2gZsN1tHBEuGV/JZw3+qCDI8EjaOtTec9Xe8ltHxkGNlDeOzSxjRPUOIr0TWHrgb5fb6+vwJ
HoviEOSBsThk+AYs/RYedP0MWrXr9RB+/eqVcvGEDDtgDVxTE8WYt+iBPUi1J8R6AB+m1zb6gqx/
vB8767XSbLebCghpgV8Ybs1UugzaMYy1FysjT4EwX8EPvPj6Sblsr6HlAr8MD4bh3zmMoZF3QqoC
L/J8/wbjuO8IOzoelt4GBTUvEOWHmwH6NM769PePY/chd+31YOA5xlsY+kpXoA0EP94Fh5wP0BdS
dYC6M8PBoCqt18BX19brG+lxAE4oXK1BMe1HeBAK04brQbV2s76/v/UDEalw3b6/vL8FIfPN7e01
On1wDc94Up5vYQVqt5dvytPDFWic754fgv6mZ9e/v5z9OG7W/wXVLmqEH3EB1j/A2xMz7Jx19oI+
5J//SWcQ7/vPPznrA8rro/86fQcddTwoyVlnrwDv++/3o+03HodwU8799WH1OfoyxyE66/8Dfx+g
hZovf/kAAAAASUVORK5CYII=
--===============1061606141==--
