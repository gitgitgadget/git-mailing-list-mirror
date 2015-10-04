From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 01/43] refs.c: create a public version of
 verify_refname_available
Date: Sun, 4 Oct 2015 08:07:02 +0200
Message-ID: <5610C206.4090307@web.de>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
 <1443477738-32023-2-git-send-email-dturner@twopensource.com>
 <560F6172.3040404@web.de> <1443891000.7753.4.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 04 08:07:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZicS7-0006B3-ND
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 08:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbbJDGHN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Oct 2015 02:07:13 -0400
Received: from mout.web.de ([212.227.15.14]:61556 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199AbbJDGHL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 02:07:11 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0M1UUr-1abh8k3g9B-00tTXZ; Sun, 04 Oct 2015 08:07:07
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <1443891000.7753.4.camel@twopensource.com>
X-Provags-ID: V03:K0:3jkc1NSMPTKvbcQG1Or0q+rBxf2+5TqptiXhTfolasKTAn8wkHW
 dYfn+D1p+S6U7uAjLMKXJXdQIcuaLGJt+Fs28VRACh8h5T8iCLq7bviToOxozxUfdlm7yq4
 e8Tjj1heb9YI+WU8BWtDFzvpf8lKe70VFFX8ZmAPY+LoMh5Th1meOFnIccb92/nIO9vFFt5
 WEYAEz3FACvqB9l8BuUVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fjR9Y/1zXCM=:IpkMbAUCFCj1I8NPD9qx9N
 VYHVJxqZtFXGhiJ4Cz5zHjdBZeVK7pNXKBP3OdkPXArKnXoliy46d+yQXa0hlSpIyzVv1IJLM
 iNTQX8rU8ezialldwt432y2kVsSNGP48FzfrmfdhMYNKY44JIFBK+PYdLSF0ps7Ue2/4PsL6r
 vbMos2dmwr2oF/MvUH2VHxwerIfeO9E1aIL5P0NQP4UyQOJ5lN+sA5bXox0kGywSVwv4G4s7O
 G2/6++LbNFyegeMxttLeDhpkdShxdVnUJpqfcUcADda2cljO3leEeRlJt8U2+Vn5ikxRgZ0+U
 WK6GfDG0Vt3E0ZXnVyYQDoT2H0g//CWYMAaukgEZHYUeQvrSHpvkm3DT+SC4fgN0izGNXtDeM
 0A2JYpVgzc50iuq+aim6Xy7I1AX7pW7VqWIi5dZ1Y5T9pgkxFJvnfbg46jHnT/RcgHAeKET+S
 zSu0cC6u6g3Fb1Dv9MNjWcjTuPFXNrzJ2qz+NNYf1ECWkhLxP4qfAPcH57itAkgutlPzWVM6D
 goY0eIEKqwvmJWGhf8GzD9itwNbTEAAEnnp/R+7tdBHG2wsk7rf6bE3Ok3fUHsLbB0+xRVs3C
 KI19PKoFOtYosxKDn0XdoHrYTUP8hQoY75Oje0HpoZiNSmNE3dvRRICtwn7jQEMJ1hcsfIe6Q
 aNKxOD66u/nm5uePRYdAy0Olz9bh1P6l/R0ubnkLxJS6yp0T6oASW2MR5VssetkHgfJkpKsRD
 PaQUTUVEJIVeYlgJhY/4+wSxznFsCVAOv9/Q+Tho1GWp9FyFHx1u2IKBPajlGAgwQHOnxeQv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278993>



On 2015-10-03 18.50, David Turner wrote:
> On Sat, 2015-10-03 at 07:02 +0200, Torsten B=C3=B6gershausen wrote:
>> On 29.09.15 00:01, David Turner wrote:
>> (Not sure if this is the right thread to report on)
>>
>> In file included from builtin/commit.c:20:
>> ./refs.h:695:16: warning: redefinition of typedef 'ref_transaction_f=
ree_fn' is a C11 feature
>>       [-Wtypedef-redefinition]
>> typedef void (*ref_transaction_free_fn)(struct ref_transaction *tran=
saction);
>>                ^
>
> Fixed, thanks.
>
> What compiler flag did you turn on to see that warning?
This compiler reported it as an error, not a warning:
gcc --version
i686-apple-darwin10-gcc-4.2.1 (GCC) 4.2.1 (Apple Inc. build 5666) (dot =
3)
Copyright (C) 2007 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is=
 NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.
