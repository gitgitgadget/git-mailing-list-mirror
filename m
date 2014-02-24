From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 5/6] Document a bunch of functions defined in sha1_file.c
Date: Mon, 24 Feb 2014 21:01:52 +0100
Message-ID: <530BA530.3070603@alum.mit.edu>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu> <1393000327-11402-6-git-send-email-mhagger@alum.mit.edu> <530B8CEB.5040903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 21:02:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI1j0-0005dQ-5t
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 21:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbaBXUB5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Feb 2014 15:01:57 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:57570 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752981AbaBXUB4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Feb 2014 15:01:56 -0500
X-AuditID: 1207440e-f79c76d000003e2c-b8-530ba533e4d3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id F6.DE.15916.335AB035; Mon, 24 Feb 2014 15:01:55 -0500 (EST)
Received: from [192.168.69.148] (p57A25CCF.dip0.t-ipconnect.de [87.162.92.207])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1OK1rFH018560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 24 Feb 2014 15:01:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <530B8CEB.5040903@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqGu8lDvY4NYUZYuuK91MFiuuzmF2
	YPLYOesuu8fnTXIBTFHcNkmJJWXBmel5+nYJ3BnNZxoZC7p5Kg6cu8TWwHiYs4uRg0NCwETi
	3f3gLkZOIFNM4sK99WwgtpDAZUaJpityXYxcQPZ5JonXF48ygyR4BbQlji37wwJiswioStzu
	/MMOYrMJ6Eos6mlmArFFBYIlVl9+wAJRLyhxcuYTMFtEwFzixP7lbCB7mQXEJfr/gYWFBXwl
	vm2+wwaxaxajRPPbNrA5nAKaEnuePmOCuFNcoqcxCKJVXWL9PCGQCmYBeYnmrbOZJzAKzkKy
	bBZC1SwkVQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrr5WaW6KWmlG5ihAQu3w7G9vUy
	hxgFOBiVeHg7irmDhVgTy4orcw8xSnIwKYnyfl4AFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC
	yz8JKMebklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuBVXALUKFiUmp5a
	kZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K3PhiYOyCpHiA9rqBtPMWFyTmAkUhWk8x6nLc
	bvv1iVGIJS8/L1VKnPfIYqAiAZCijNI8uBWwNPWKURzoY2FePZBRPMAUBzfpFdASJqAlhRYc
	IEtKEhFSUg2Mwg+Zu9hPHyh5tsopynPSknW6xyYK7te7fuf2ttRlq0/MW9z8RWptrzmjnUei
	6dcf0noGAnfEDSRi9Xhnx6+vebhBvnLR5Lm3nR1K+5IWHXI4fVj3+Of0WIN5m3av 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242636>

On 02/24/2014 07:18 PM, Jakub Nar=C4=99bski wrote:
> Michael Haggerty wrote:
>=20
>> -/*
>> - * NOTE! This returns a statically allocated buffer, so you have to=
 be
>> - * careful about using it. Do an "xstrdup()" if you need to save th=
e
>> - * filename.
>> - *
>> - * Also note that this returns the location for creating.  Reading
>> - * SHA1 file can happen from any alternate directory listed in the
>> - * DB_ENVIRONMENT environment variable if it is not found in
>> - * the primary object database.
>> - */
>>   const char *sha1_file_name(const unsigned char *sha1)
>=20
> Has this changed?

No, this hasn't changed.  I've been documenting public functions in the
header files above the declaration, and private ones where they are
defined.  So I moved the documentation for this function to cache.h:

+/*
+ * Return the name of the file in the local object database that would
+ * be used to store a loose object with the specified sha1.  The
+ * return value is a pointer to a statically allocated buffer that is
+ * overwritten each time the function is called.
+ */
 extern const char *sha1_file_name(const unsigned char *sha1);

I also rewrite the comment, as you can see.  The "NOTE!" seemed a bit
overboard to me, given that there are a lot of functions in our codebas=
e
that behave similarly.  So I toned the warning down, and tightened up
the comment overall.

Let me know if you think I've made it less helpful.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
