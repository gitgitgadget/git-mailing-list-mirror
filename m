Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C84812E1F6
	for <git@vger.kernel.org>; Thu,  9 May 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263592; cv=none; b=gEsxzXcT3dWJbZfsRQ3GfCROPoQ7+ilAD8fFXrJAzOHcq9OJLSu3SiQpuxxEw3B/l8SprQsajLpfOWhkA1XWAArT15NSkMzYyaJFBnUTuMxgWvRbgibl28K0i0RZHWG/21hyFKxYVoRcbiBLfoglgnZcmUj8Mi045aw+Y/pPOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263592; c=relaxed/simple;
	bh=5sB0yipW7Y8GzyHXHxMGmDnPMg0+pziY6Tsgphbvuek=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=NwC6zdu4AhyuV+BVrDft6yY+MRdbWOzCPmov1AVjJLD766aTZgnAjVrWn9NuEQzID/gLifH29mX0oz4f9vXirEX3b+sD9E9BhOK/h3YQ9UAH2prMmffBnwkCZq5mTMnGZZ26GVxnTgKT+5KDUW82GsH1Csh7g5pxq/U4tgDg0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.maltese.cc; spf=none smtp.mailfrom=dev.maltese.cc; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.maltese.cc
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dev.maltese.cc
Received: from oxusgaltgw15.schlund.de ([10.72.72.62]) by mrelay.perfora.net
 (mreueus002 [172.19.143.1]) with ESMTPSA (Nemesis) id
 0Lkf2I-1sd2Ff2Nc4-00ceCt for <git@vger.kernel.org>; Thu, 09 May 2024 16:06:23
 +0200
Date: Thu, 9 May 2024 10:06:23 -0400 (EDT)
From: dev@dev.maltese.cc
To: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <21209940.11022921.1715263583414@email.ionos.com>
Subject: $PWD expanding to incorrect value Podman run command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11022920_2100029682.1715263583412"
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev59
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:kG61SrmuVDsHS5lpY9Ct+7QFbSpHa9S1oov1zXB46XD0qNtOpWr
 w+WXNJ2FToqm31d+cbPlD2+tU62Oigg7BT0thVuYMI9OCZ7PJuhh+tZVQV3dwkPlPQU8Cf7
 EdsxvWOxnV+uCKsw2umk7Dk1Q5vaDwcPv0nVPmQ6t3RCIerCBK0fV2K/VU3nRXuhZIOEbiZ
 J5ywKtT6PqGyFTRuQz3pA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m85zTvIbr+I=;+lwO4/pNw1lZ04SLNDrIguvdcE6
 GGcyNnCwBy0Hq1QtD7+MnPYyx++BmUPbYdAaqIHvf9jk2Io+qvTejWbPvFtj28NoKWf3CZJFf
 PJpqRhQ+8oFQFEpFPjoXFcTAbm7g+FDUyFXHVoFtqv9ZXyI3hEyGlC8saNf1qDaUO5SEBAFnc
 fyitz4j527M1A5/pgnIDIxhry5w6dWj1X44xk6I4XHfpQDgJtPk88CuqlJNeQdyO0IwrKH6vn
 rHLlNLkG3kkK8H+fsy7iitrBVNrv6KX08PeyIMAEHD0BO1KGStE5doM3eMOPRDiWiEMSGJBVj
 FmwQsq01q6J60b9R1QDX566Sbx9S3Vjd6Mc17rM8B7FMs7SzFKHeRK9PJPR5JbBRyHQQdDm23
 gzbINpzkcYt3qzKOK8h57CUw9kaga/w9FpDLoyhDRkASoltwUrG/N+GLVKqBDGAK1N5apk5Bj
 ucxeKNp1zNcc+XTHXBSpZ/mmqmlgg3NcwCmkH9X/ElPo7hy19NWhFQPNzYfCegx5CZcCAdXMh
 XWHmeVNJpEh7JZiKn8tgk4l+7WCdOSbHJguXKVtcgcVwbG0BKTmbQB12BN5/NhwI94etFMeAR
 ZXd3/yjOHvlDIjFjgXnE2n2aEavStPeZCrxGfH2yP9+M4hTe1fWcGSwAAMG0RO6gVmfQh15An
 EHGRhLTtoienhc6U+shLbKLJ/RGWY/mK9sfpsf8ldMY/hTFT4fsz0ErC0rfrGlNz8U+HiJTmE
 EiJDYEBiaNYWq3E6w/MmmMrVrIYTKgTtg==

------=_Part_11022920_2100029682.1715263583412
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!doctype html>
<html>
 <head> 
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
 </head>
 <body> 
  <div class="default-style"> 
   <div class="default-style">
     Thank you for filling out a Git bug report! 
    <br>Please answer the following questions to help us understand your issue. 
   </div> 
   <div class="default-style">
     &nbsp; 
   </div> 
   <div class="default-style">
     What did you do before the bug happened? (Steps to reproduce your issue) 
    <br>Installed podman and executed: "$ podman run -p 8081:80 -v $PWD:/usr/share/nginx/html nginx" 
   </div> 
   <div class="default-style">
     &nbsp; 
   </div> 
   <div class="default-style">
     What did you expect to happen? (Expected behavior) 
    <br>Expected the nginx image to run and map the current directory to the '/usr/share/nginx/html' directory. 
   </div> 
   <div class="default-style">
     &nbsp; 
   </div> 
   <div class="default-style">
     What happened instead? (Actual behavior) 
    <br>Received the error "Error: invalid container path "\\Program Files\\Git\\usr\\share\\nginx\\html", must be an absolute path". 
   </div> 
   <div class="default-style">
     &nbsp; 
   </div> 
   <div class="default-style">
     What's different between what you expected and what actually happened? 
    <br>I expected the docker $PWD (or ${PWD} or $(pwd) or $HOME) to expand to the actual working directory, but it seems to expand to the directory of the gitbash executable. 
   </div> 
   <div class="default-style">
     &nbsp; 
   </div> 
   <div class="default-style">
     Anything else you want to add: 
   </div> 
   <div class="default-style">
     &nbsp; 
   </div> 
   <div class="default-style">
     Please review the rest of the bug report below. 
    <br>You can delete any lines you don't wish to share. 
   </div> 
   <div class="default-style"> 
    <br>[System Info] 
    <br>git version: 
    <br>git version 2.41.0.windows.1 
    <br>cpu: x86_64 
    <br>built from commit: ff94e79c4724635915dbb3d4ba38f6bb91528260 
    <br>sizeof-long: 4 
    <br>sizeof-size_t: 8 
    <br>shell-path: /bin/sh 
    <br>feature: fsmonitor--daemon 
    <br>uname: Windows 10.0 19045 
    <br>compiler info: gnuc: 13.1 
    <br>libc info: no libc information available 
    <br>$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe 
   </div> 
   <div class="default-style"> 
    <br>[Enabled Hooks] 
    <br>not run from a git repository - no hooks to show 
   </div> 
  </div> 
 </body>
</html>
------=_Part_11022920_2100029682.1715263583412
Content-Type: text/plain; charset=UTF-8;
 name=git-bugreport-2024-05-09-0954.txt
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=git-bugreport-2024-05-09-0954.txt
X-Part-Id: 8fa9fc7560e740688ee6124654eb7167

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCkluc3RhbGxlZCBwb2RtYW4gYW5kIGV4ZWN1dGVkOiAiJCBwb2Rt
YW4gcnVuIC1wIDgwODE6ODAgLXYgJFBXRDovdXNyL3NoYXJlL25naW54L2h0bWwgbmdpbngiCgpX
aGF0IGRpZCB5b3UgZXhwZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQpFeHBlY3Rl
ZCB0aGUgbmdpbnggaW1hZ2UgdG8gcnVuIGFuZCBtYXAgdGhlIGN1cnJlbnQgZGlyZWN0b3J5IHRv
IHRoZSAnL3Vzci9zaGFyZS9uZ2lueC9odG1sJyBkaXJlY3RvcnkuCgpXaGF0IGhhcHBlbmVkIGlu
c3RlYWQ/IChBY3R1YWwgYmVoYXZpb3IpClJlY2VpdmVkIHRoZSBlcnJvciAiRXJyb3I6IGludmFs
aWQgY29udGFpbmVyIHBhdGggIlxcUHJvZ3JhbSBGaWxlc1xcR2l0XFx1c3JcXHNoYXJlXFxuZ2lu
eFxcaHRtbCIsIG11c3QgYmUgYW4gYWJzb2x1dGUgcGF0aCIuCgpXaGF0J3MgZGlmZmVyZW50IGJl
dHdlZW4gd2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdoYXQgYWN0dWFsbHkgaGFwcGVuZWQ/CkkgZXhw
ZWN0ZWQgdGhlIGRvY2tlciAkUFdEIChvciAke1BXRH0gb3IgJChwd2QpIG9yICRIT01FKSB0byBl
eHBhbmQgdG8gdGhlIGFjdHVhbCB3b3JraW5nIGRpcmVjdG9yeSwgYnV0IGl0IHNlZW1zIHRvIGV4
cGFuZCB0byB0aGUgZGlyZWN0b3J5IG9mIHRoZSBnaXRiYXNoIGV4ZWN1dGFibGUuCgpBbnl0aGlu
ZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoKClBsZWFzZSByZXZpZXcgdGhlIHJlc3Qgb2YgdGhlIGJ1
ZyByZXBvcnQgYmVsb3cuCllvdSBjYW4gZGVsZXRlIGFueSBsaW5lcyB5b3UgZG9uJ3Qgd2lzaCB0
byBzaGFyZS4KCgpbU3lzdGVtIEluZm9dCmdpdCB2ZXJzaW9uOgpnaXQgdmVyc2lvbiAyLjQxLjAu
d2luZG93cy4xCmNwdTogeDg2XzY0CmJ1aWx0IGZyb20gY29tbWl0OiBmZjk0ZTc5YzQ3MjQ2MzU5
MTVkYmIzZDRiYTM4ZjZiYjkxNTI4MjYwCnNpemVvZi1sb25nOiA0CnNpemVvZi1zaXplX3Q6IDgK
c2hlbGwtcGF0aDogL2Jpbi9zaApmZWF0dXJlOiBmc21vbml0b3ItLWRhZW1vbgp1bmFtZTogV2lu
ZG93cyAxMC4wIDE5MDQ1IApjb21waWxlciBpbmZvOiBnbnVjOiAxMy4xCmxpYmMgaW5mbzogbm8g
bGliYyBpbmZvcm1hdGlvbiBhdmFpbGFibGUKJFNIRUxMICh0eXBpY2FsbHksIGludGVyYWN0aXZl
IHNoZWxsKTogQzpcUHJvZ3JhbSBGaWxlc1xHaXRcdXNyXGJpblxiYXNoLmV4ZQoKCltFbmFibGVk
IEhvb2tzXQpub3QgcnVuIGZyb20gYSBnaXQgcmVwb3NpdG9yeSAtIG5vIGhvb2tzIHRvIHNob3cK

------=_Part_11022920_2100029682.1715263583412--
