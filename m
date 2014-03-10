From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 03/26] t1400: Pass a legitimate <newvalue> to update command
Date: Mon, 10 Mar 2014 22:38:31 +0100
Message-ID: <531E30D7.40208@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu> <1394455603-2968-4-git-send-email-mhagger@alum.mit.edu> <531DF079.9050909@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 22:38:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN7uE-0000bP-LV
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 22:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbaCJVii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 17:38:38 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60563 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752703AbaCJVig (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 17:38:36 -0400
X-AuditID: 1207440d-f79d86d0000043db-23-531e30dbb695
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id BB.AE.17371.BD03E135; Mon, 10 Mar 2014 17:38:35 -0400 (EDT)
Received: from [192.168.69.148] (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ALcVZm020415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 17:38:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531DF079.9050909@kitware.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsUixO6iqHvbQC7Y4OJBXYud6yQsuq50M1k0
	9F5htph3dxeTxY+WHmaLj50LmB3YPHbOusvucenldzaPj8+Ws3s8693D6HHxkrLH501yAWxR
	3DZJiSVlwZnpefp2CdwZv7/0MhcsF604e+gAawPjVoEuRk4OCQETiTkb2lkgbDGJC/fWs3Ux
	cnEICVxmlJi69T8ThHOeSeJUy3x2kCpeAU2JI7dnMYLYLAKqEueWHGQGsdkEdCUW9TQzgdii
	AsESqy8/YIGoF5Q4OfMJmC0CVL9qXQMbiM0ssIZR4ubGGhBbWCBAYs+PZqjNsxglbi/pABvE
	KaAtMX/BeiCbA+g8cYmexiCIXh2Jd30PmCFseYntb+cwT2AUnIVk3SwkZbOQlC1gZF7FKJeY
	U5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopeaUrqJERIPvDsY/6+TOcQowMGoxMN74K1MsBBr
	YllxZe4hRkkOJiVR3jwduWAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzrxIFyvCmJlVWpRfkw
	KWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3hX6QI2CRanpqRVpmTklCGkmDk6Q4VxS
	IsWpeSmpRYmlJRnxoBiOLwZGMUiKB2hvIUg7b3FBYi5QFKL1FKMux+22X58YhVjy8vNSpcR5
	S0CKBECKMkrz4FbAkt8rRnGgj4V5j4BU8QATJ9ykV0BLmICWNB+XAllSkoiQkmpg7OfNf/tA
	+IVixpnZMVPkI+ofRHa85rvK4eC0wt7F9OLZdZrWK68yuHh3+c/XusV/vmPueZ/1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243820>

Brad,

Thanks for your feedback.

On 03/10/2014 06:03 PM, Brad King wrote:
> On 03/10/2014 08:46 AM, Michael Haggerty wrote:
>> This test is trying to test a few ways to delete references using "git
>> update-ref -z --stdin".  The third line passed in is
>>
>>     update SP /refs/heads/c NUL NUL <sha1> NUL
>>
>> , which is not a correct way to delete a reference according to the
>> documentation (the new value should be zeros, not empty).  Pass zeros
>> instead as the new value to test the code correctly.
> 
> In my original work on this feature, an empty <newvalue> is allowed.
> Since newvalue is not optional an empty value can be treated as zero.
> The relevant documentation is:
> 
>  update::
>          Set <ref> to <newvalue> after verifying <oldvalue>, if given.
>          Specify a zero <newvalue> to ensure the ref does not exist
> 
>  ...
> 
>  Use 40 "0" or the empty string to specify a zero value, except that
>  with `-z` an empty <oldvalue> is considered missing.
> 
> The two together say that <newvalue> can be the empty string instead
> of a literal zero.

OK, with your explanation and after reading the docs a couple more
times, I can see your reading.  Your rules as I now understand them:

* Without -z
  * 0{40} or the empty string represents zeros
  * No preceding SP delimiter indicates that the value is missing
    (as are any following values)

* With -z
  * For <newvalue>
    * 0{40} or the empty string represents zeros (the value is
      not allowed to be missing)
  * For <oldvalue>
    * 0{40} represents zeros
    * The empty string indicates that the value is missing

I implemented the slightly simpler rules

* Without -z
  * 0{40} or the empty string represents zeros
  * No preceding delimiter indicates that the value is missing (as
    are any following values)

* With -z
  * 0{40} represents zeros
  * The empty string indicates that the value is missing

It seems to me that "-z" input will nearly always be machine-generated,
so there is not much reason to accept the empty string as shorthand for
zeros.  So I think that my version of the rules, being simpler to
explain, is a slight improvement.  But your version is already out in
the wild, so backwards-compatibility is also a consideration, even
though it is rather a fine point in a rather unlikely usage (why use
update rather than delete to delete a reference?).

I don't know.  I'm willing to rewrite the code to go back to your rules,
or rewrite the documentation to describe my rules.

Neutral bystanders *cough*Junio*cough*, what do you prefer?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
