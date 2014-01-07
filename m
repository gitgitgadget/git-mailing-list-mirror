From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 03/17] safe_create_leading_directories(): add explicit
 "slash" pointer
Date: Tue, 07 Jan 2014 10:26:44 +0100
Message-ID: <52CBC854.2060602@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu> <1389015935-21936-4-git-send-email-mhagger@alum.mit.edu> <xmqqppo5hsf9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 10:27:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Sw7-0005hV-G3
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 10:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbaAGJ0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 04:26:54 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:48389 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752059AbaAGJ0v (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 04:26:51 -0500
X-AuditID: 1207440c-b7f566d000004272-0c-52cbc85a7cf4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id DE.B7.17010.A58CBC25; Tue,  7 Jan 2014 04:26:50 -0500 (EST)
Received: from [192.168.69.148] (p57A25E76.dip0.t-ipconnect.de [87.162.94.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s079Qj0e010500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Jan 2014 04:26:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <xmqqppo5hsf9.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsUixO6iqBt14nSQQftUQYuuK91MFg29V5gt
	3t5cwmixe9oCNovTN+ezO7B67Jx1l93j4iVlj8cTT7B6fN4kF8ASxW2TlFhSFpyZnqdvl8Cd
	ce3/JcaCCYIVB+YsZW9gvMnbxcjJISFgIrHy42Z2CFtM4sK99WxdjFwcQgKXGSUenjvGAuGc
	Y5JY03WPCaSKV0Bb4taOK4wgNouAqsSJvlMsIDabgK7Eop5msBpRgSCJR4ceskPUC0qcnPkE
	rEZEQE1iYtshsKHMAssYJTqW/wUbJCwQLzHv1U8miG1rGCUWnDrPBpLgFLCW2PT+E9AkDqD7
	xCV6GoNAwswCOhLv+h4wQ9jyEtvfzmGewCg4C8m+WUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1
	Wbc4OTEvL7VI11AvN7NELzWldBMjJOh5djB+WydziFGAg1GJh/fF3lNBQqyJZcWVuYcYJTmY
	lER5ZXadDhLiS8pPqcxILM6ILyrNSS0+xCjBwawkwntnI1CONyWxsiq1KB8mJc3BoiTOq7pE
	3U9IID2xJDU7NbUgtQgmK8PBoSTB63scqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0
	JCMeFMXxxcA4BknxAO1dfhRkb3FBYi5QFKL1FKMux7wvH74xCrHk5eelSonzuoHsEAApyijN
	g1sBS3GvGMWBPhbmVQep4gGmR7hJr4CWMAEtCY07BbKkJBEhJdXAqHGKyZP/9urEWSvM3hem
	T/BY/nNO0vS15pcmVuvu61Z8mr2NLV9fUvbYnS9v0hjVLFcE+hyXbr10IVzLuVnB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240101>

On 01/06/2014 07:32 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Keep track of the position of the slash character independently of
>> "pos", thereby making the purpose of each variable clearer and
>> working towards other upcoming changes.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
> 
> This step has an interaction with $gmane/239878 where Windows folks
> want it to pay attention to is_dir_sep()---over there, a backslash
> could separate directory path components.
> 
> AFAIK, the function was meant to be used only on paths we internally
> generate, and the paths we internally generate all are slash
> separated, so it could be argued that feeding a path, whose path
> components are separated by backslashes, that we obtained from the
> end user without converting it to the internal form in some
> codepaths (e.g. "$there" in "git clone $url $there") are bugs we
> acquired over time that need to be fixed, but it is easy enough to
> use is_dir_sep() here to work it around, and doing so will
> not negatively affect
> 
>  1. UNIX-only projects by forbidding use of a byte with backslash in
>     it as a path component character (yes, I am imagining using
>     Shift-JIS that can use a backslash as the second byte of
>     two-byte character in the pathname on UNIX); and
> 
>  2. UNIX-and-Windows mixed projects, as you cannot sanely use such a
>     pathname with backslash as part of a path component if its tree
>     needs to be checked out on Windows.

I agree that it would be reasonable to use is_dir_sep() in the
implementation of this function, at least unless/until somebody does the
work to figure out whether callers should really only be passing it
forward-slash-normalized paths.

Please be careful, though, because I don't think this function is
capable of handling arbitrary Windows paths, like for example
//host/path format, either before or after my change.

Let me know if you would like me to merge or rebase the is_dir_sep()
changes into this patch series.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
