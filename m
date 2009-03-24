From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Tue, 24 Mar 2009 02:20:13 +0200
Message-ID: <94a0d4530903231720r620e44fu90dd77a3231bd4d1@mail.gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
	 <20090323064242.GB1119@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 01:21:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LluOq-0003FN-Gx
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 01:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850AbZCXAUS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 20:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbZCXAUS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 20:20:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:46606 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbZCXAUQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 20:20:16 -0400
Received: by fg-out-1718.google.com with SMTP id e12so594584fga.17
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 17:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S7i9Q60ksFgCB6bHXR1z8DKYrdAfsWaKhY8dPY6AoWs=;
        b=WsqbTTz6SH0HZ3QRQPJ74o1mwgJKmL3wYCKZ15MYQKFWIftcnHDpOCQukGoFmFPvFh
         qNhWVORm2E7+pk4o33/BO/bfi4e7mfE7RgGpPVxolheyNMSkL0+CzQrwjWn4Dn/R07nE
         EhJLPbNovvlWPS/5XOQPVRTVsW2MBhjUP8HSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bFqpVwceCleCh5XRpQsEEI22XfhHTjUQ3w+ZKsZ5PD9+Dua0Ac7oIRJhT/DIhQJW/l
         7wUibBoHBfRpal1L7bAyBRPOCsy0zX8HG+tZi11+t9SQuZTPYC8UFLfNHtGAFmKe0I+/
         gK2WiBtjP3cjUJqE6q1kIjT/SBq2rgb4X5eWQ=
Received: by 10.86.70.3 with SMTP id s3mr4138935fga.65.1237854013277; Mon, 23 
	Mar 2009 17:20:13 -0700 (PDT)
In-Reply-To: <20090323064242.GB1119@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114369>

On Mon, Mar 23, 2009 at 8:42 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 22, 2009 at 08:05:15PM +0200, Felipe Contreras wrote:
>
>> =C2=A0tt.literal, code.literal {
>> =C2=A0 =C2=A0color: navy;
>> + =C2=A0font-size: 1em;
>> +}
>
> Isn't 1em already the default size? Or are you trying to override som=
e
> other size specification elsewhere? It's hard to tell what the goal i=
s
> because your commit message merely says "improve".

I've updated the CSS. Can you take a look again?

I changed the font-size to normal, except for the code chunks. Also, I
changed the font of the in-paragrah code tags to sans-serif, that's
the most sane way I can think to fix the problem with different
font-size configured for monospace font.

I also reverted the line-height change.

--- a/Documentation/docbook-xsl.css
+++ b/Documentation/docbook-xsl.css
@@ -15,9 +15,8 @@ body blockquote {

 html body {
   margin: 1em 5% 1em 5%;
-  line-height: 1em;
+  line-height: 1.2;
   font-family: sans-serif;
-  font-size: small;
 }

 body div {
@@ -130,7 +129,7 @@ body pre {

 tt.literal, code.literal {
   color: navy;
-  font-size: 1em;
+  font-family: sans-serif;
 }

 code.literal:before { content: "'"; }
@@ -148,6 +147,7 @@ div.literallayout p {

 div.literallayout {
   font-family: monospace;
+  font-size: small;
   margin: 0em;
   color: navy;
   border: 1px solid silver;

--=20
=46elipe Contreras
