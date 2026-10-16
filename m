Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C730567F
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190227; cv=pass; b=qCc+zsDajOr3QxIKgy5xn7++JmYzn0LLPBpioW+hZzrb1+C0k/9Izsbr0oGF5jvV2QYduPJhjb0h57vWPx7hAAMZC3d//m1b847gBX7yC0PlOIFwbspnOGYcKusbcnPfaa3viQ/iw65Wp5lf735hVh3cQF8EAFZ6z7B/3Msg8c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190227; c=relaxed/simple;
	bh=wBe/L+JaXCcrBHRCpF4cyQ8v6D9+0d0b8nl7hSnh9ys=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WujL1mEeAbI8ps9BTxM8xsZl8Kk1bMzrW1P8ievAsU4MDdZmXebZLls5USTKJoMlsVwsawAbO9+uPwP3HGKgvJ9gHVMb0ZN2aMapxlLRE51Cv1u05Nr5/kYjr0kBOfo5VfvP96mj4KO66M25NpNm8AMI8WioZvDfqomzTkZxrF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSLwMT+0; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSLwMT+0"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6798d4ab549so525293d50.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 15:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792190225; cv=none;
        d=google.com; s=arc-20260327;
        b=BYNsgIZ1cBXVSLeF/SQxLMczR8la1PP2fKX08fNSCcNFlAgRGolMAogVCF3i4Qc1Yu
         aIDUwcFNa9JfdJt1QXj5cdc4wCaJK46Awn8gv25AF1NXE9gB7Fw4xT79oB62Wzj8q5Co
         nmBrkiTDnXybiFw98scwqvk/R5MYWZvkr0vVlN1Bt1A/f038xiG57g9G3lO+1TXSA2ot
         mI6McrObZbrUMOXa1gRM4urbQfWBAjxpKxePb5a+72xlRNQbXSp+Vj7YTkwbICHZwBBn
         acpVIGnZFqiJ0Q0W2Dy8nFIGNCfV8BVvS6yhjeH6LkugVMPwbbKYAFAuTmseAYBYXRDP
         wS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=bS7VHuaRsThcUIC1nmC9uQfOshuNUL6XQGCv/bkFsFc=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=PHoVsQJJseEzZymaxqHHLgLwwOzwOijN8wKXL6C2DyTTW2FxcReuOTlj+N2ckVk4OL
         QwHK5JUEhXKGt+JmVWnlQnTCUmPyCiXA0wuMedZQ89HgSNqB+N2YhPMgAqVLXHyQQLF8
         vvNM2m7JL85vkDRJ3NVuHctYZIVoyFmkKuYjyoJ4DlIo3Onqwbgs5DZC6Xl1sfk3e0t3
         sUpf7KYfoIVCUGq6LvnATzVIDmyfuwS3g+g4NDiA2iqiBw8c0MenYznszsC8SAauDjph
         l3eB7rq45XI2s9aE8cQv4JbbpdqIfwSr0ZeVjvxMR+yJPm9fnoF6aMWKColY6hDA1yQI
         Gepw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792190225; x=1792795025; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bS7VHuaRsThcUIC1nmC9uQfOshuNUL6XQGCv/bkFsFc=;
        b=pSLwMT+0SrcjtYtlIJidA9e9hRWwK+Xq7BDcnzSY9aAfMWWftN6bqAqssacS0a3A14
         t10tQz7s2OKMbAMW8IthyZtRSpkNqkqJv308rDCpEhX22JQMKOL/3KUsnFnEnVxMCPsZ
         iS9rpfVDJBBE7WpCBwHJavilm4OHrl4pXJ4YZg/uPRHZ+zV22j2DSBCEujrfh/NCjZet
         pQRtU9apglNcLuIIozRDh7FsLucDZ8sipnuoX2xCq+GFFMCaJyLYOM2eUjBluxQTaGd8
         OWCTTke3v/h7cTcWstRhvr+bAqMyESjD2Ylt/gOYyp6xQ76Zhxh/dhyMYlLfH4M0tp7J
         FhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792190225; x=1792795025;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bS7VHuaRsThcUIC1nmC9uQfOshuNUL6XQGCv/bkFsFc=;
        b=cFlZSisgardYfk8VkJtfsIw1vHHjwH9Wk47KHhj6M6IYJmuNYhl7YiL2Xh9HO+gsnT
         pHxpKAnJTuEoCqVmhSM4GOm6xOBoLwD0bS75eceNvFtGYlANU0TRm94QGz9pq9S3lqlY
         NObYIO4sfdvh8FPQyRbrVrKf2SZs8ukjfv+fwwlrT4Gkv0WH2t1QQRw6rr6XibOC2QTa
         RLlAT1aKToJIWZq0Y+6/TIML42ZyD4jBxWIjnxkeSXt3EMwglPFdNrXtfLibXRBP/Xc4
         WooYcD95JZXmSz2wNhYd83Xq97O075yBYqT3sEpaAPczKhGHyWYrGvqXjTe/1elAoOf7
         Pm5Q==
X-Gm-Message-State: AFq9FYLU7ZDzTCLHGK3coiDDIwYCQqvVG2+pagnWIY6dADC8ktvUtUWf
	Jh/X06zZCuytK6lI3SqGBXhtZdBEkGQ3IgW3Ctb8z5d33GFsjGE4P7bOHGfDPDJYE4BeC5N75dV
	YKg3rAMoUXyM3SkyGTtvOcwEhyWPDoEpBiroNJIg=
X-Gm-Gg: AYBFou33vdGj8xIXKVe82CTZMDRJK7yixUf0xD3N2h3Fnue01+7E3TmboBHJ8+NGLeD
	sjuizvZQCJ8j0POiyfc6soxMJD3NAOH6/+RW5om7FQxvJxQpQt9vAAnkIVA5t9SmgSo7V/WuqYe
	W+ylBh7sCZnry6MtkHlgTEASMYR+FTqCFGW8z9g+e+QTasPQZYlJnqVv9AMs/QKgzcIs59auH4x
	OCnfKzckV3OqS+GKHi+EspnItgS1jH4cT5pN3LHwNTs+q7VCN62rUChc6iT7pekdHCEiM1tMe0M
	0tLxboP4QL8/CR0Walrp5VzVJV512xqeEC4C2ymnD/5Ybe0+QiRsGIY=
X-Received: by 2002:a05:690e:1486:b0:679:985a:3fc3 with SMTP id
 956f58d0204a3-679ca8c48f0mr345389d50.85.1792190224574; Fri, 16 Oct 2026
 15:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan <timelord@gmail.com>
Date: Fri, 16 Oct 2026 15:36:53 -0700
X-Gm-Features: AclHuK-Qq9qi6kWYhXoGtEA5XGJ31HGShUcO4YGlvdem_QJ3R4FqLpuN1p6r1dQ
Message-ID: <CALGWHBdx0V95RoZJvyC7G4t4RpXpQm3ycv+huTQcPunOCm7hBw@mail.gmail.com>
Subject: [BUG] http: push with token-only URL userinfo fails after libcurl
 strips creds from CURLINFO_EFFECTIVE_URL
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

(Please note this was done with the assistance of Claude, I apologize
if there are inaccuracies here, Ive tried to go over this and verify
as much of it as I am capable of. I tried looking at the mailing list
archives to see if this has already been reported and I didnt see
anything that looked like it had yet. I can verify that the new
libcurl behavior absolutely seems to be causing issues from at least
my own limited vantage point. -Dan)

Since libcurl stopped returning credentials in CURLINFO_EFFECTIVE_URL
(curl 8.23.0, commit 7a6bd027d0de "getinfo: make sure
CURLINFO_EFFECTIVE_URL does not contain creds", CVE-2026-94266; also
backported to Ubuntu 24.04 as curl 8.5.0-2ubuntu10.16, USN-8932-1),
pushing over smart HTTP fails when the remote URL carries a username
but no password, e.g.

    https://<token>@forge.example/owner/repo.git

which is a common way for CI tools to pass an access token (Renovate
does this for Gitea/Forgejo). Fetch/clone keep working; push does not.

Versions
--------
  git 2.55.0 (1:2.55.0-0ppa1~ubuntu24.04.2)
  libcurl3t64-gnutls 8.5.0-2ubuntu10.16    -> fails
  libcurl3t64-gnutls 8.5.0-2ubuntu10.15    -> works (same git build)
  Server: Forgejo 16.0.6 (answers the first unauthenticated request
          with 401 + "WWW-Authenticate: Basic realm=...")

Reproduce
---------
  git clone https://<token>@forge.example/owner/repo.git && cd repo
  git commit --allow-empty -m test
  GIT_TERMINAL_PROMPT=0 git push origin HEAD:refs/heads/test

Expected: push succeeds (it did with the previous libcurl).
Actual:

  Pushing to https://forge.example/owner/repo.git
  warning: redirecting to https://forge.example/owner/repo.git/
  POST git-receive-pack (815 bytes)
  fatal: could not read Username for 'https://forge.example': No such
device or address
  send-pack: unexpected disconnect while reading sideband packet
  fatal: the remote end hung up unexpectedly

No redirect happens on the server side; the server log shows
GET info/refs 401 -> GET info/refs 200 -> POST git-receive-pack 401.

GIT_TRACE_CURL (abridged, credentials redacted):

  => Send header: GET /owner/repo.git/info/refs?service=git-receive-pack HTTP/2
  <= Recv header: HTTP/2 401
  <= Recv header: www-authenticate: Basic realm="Gitea"
  == Info: Issue another request to this URL:
'https://<cred>@forge.example/owner/repo.git/info/refs?service=git-receive-pack'
  == Info: Server auth using Basic with user '<redacted>'
  => Send header: GET /owner/repo.git/info/refs?service=git-receive-pack HTTP/2
  => Send header: Authorization: <redacted>
  <= Recv header: HTTP/2 200
  warning: redirecting to https://forge.example/owner/repo.git/
  == Info: [HTTP/2] [5] OPENED stream for
https://forge.example/owner/repo.git/git-receive-pack
  => Send header: POST /owner/repo.git/git-receive-pack HTTP/2
     (no Authorization header)
  <= Recv header: HTTP/2 401

Analysis
--------
In http.c, http_request_reauth() calls update_url_from_redirect() with
the URL git asked for and CURLINFO_EFFECTIVE_URL. The asked-for URL
still contains "<token>@", but libcurl now returns the effective URL
without userinfo, so the strcmp() differs and git treats an ordinary
200 as a redirect: it prints "redirecting to ...", rewrites base_url to
the credential-less URL and calls credential_from_url(&http_auth, ...)
on it, which credential_clear()s http_auth.

With a username-only URL, http_auth.password was never set, so
init_curl_http_auth() never put CURLOPT_USERNAME/PASSWORD on the handle;
the only auth curl had was the userinfo in the URL. Once the URL is
rewritten, the POST goes out with no credentials, gets 401, and
credential_fill() has nothing to fill from (http_auth was cleared,
no helper, no terminal), hence "could not read Username".

With "user:password@" in the URL the same false redirect happens, but
the push still succeeded in my test - presumably because
init_curl_http_auth() had already set CURLOPT_USERNAME/PASSWORD on the
reused handle before http_auth was cleared.

Possible fix
------------
Compare the URLs without userinfo in update_url_from_redirect() (strip
"user[:pass]@" from the asked-for URL, or from both, before the
strcmp/skip_prefix), so a credential-free effective URL that is
otherwise identical is not treated as a redirect. For a real redirect
on the same origin, keeping the existing http_auth instead of
re-parsing it from a credential-less URL would also avoid losing the
username. I haven't written or tested a patch.

Workaround for users: use "user:token@" instead of "token@" in the URL,
or provide the token through a credential helper.

Thanks,
Daniel Spisak
