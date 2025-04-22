Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2477627D779
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325085; cv=fail; b=BVkLYJUacs9edMqvkDB+LogTYgFRv7jWv+kKrHHmtf7DWVPKBxOfOcUM6hySidwDFRjX4pd76FrOP2aQT7lTaUp6mbT2sSGpAgDCwIoESjyOLfwcNPr5FV5iud5oNtz8iCkgvODvKxFIoRTetoiZasL5PYFs+ZgkvzM6Uvjh7xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325085; c=relaxed/simple;
	bh=uUGJ0aGROa83CVaAueBMsXToBXvwVsLjZus/5JehNoM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cCVFJWgmZLPxtYAPX+see9TmQbouJHNFLRFXN84DSK8GH+sfPCpo4Lrefie4PzlZyS/d5XTieIe9TL7w/FMwrP9rxohyfOlkhBIl3wC1S3fCR2AzsaEvnO5An1CVuEYR+0fwNgXmU1Gvxw/yjE+E638QrcMv6ynBZt1PsKKzhSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dgB5P9g+; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dgB5P9g+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBbPSU016875
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 12:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=8Sy3GfYIvO514Ipvg8lZDpuuMElA
	+cTVbNbIjkGpERY=; b=dgB5P9g+2a9nXnsyD+PeLUtdnmJ9P/rXjiCSqLt1gWLP
	nMRbaWU87MMLNBMSEyyN/+izRasKyRV3BtPbdFVTzYvbhSkcWd706SVG5xPHitjY
	QY2lftHzn9rnwiPEgz51itZjcVhaJe5Bt7iUbHguMkJFTENJvJiaGx8YKHohj014
	6CVIlwMncEn2fjqyEdNHgFW63FOETc2dutLNxTt1NJYB/ohxvX8FUUhimnPr9Fi1
	sp64RrbGjrWM++ga08wapWo2uBZgC46rNfspv4arcBfNOgpNCB7cFRwuVWWUmyS5
	l5pGYe9YVcjowFZhQ7qQQ77yF20ulWqjyFpaNulxYg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466ad3r81y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 12:31:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gydaAV9vafpGbW9DlgKS/5yaeL08VXU+xAg3BtfZ8wmXWy42GEJ3xonQGnzjFvczsyx1phPCNYWHcREYZ8bnonShQSD/ydbdtd+K0ltgo1IjOTIFA9j6op46az1G/CCnJmX2Al5GB4vZVB9hP0xeVCBFTRzzdSI3IpXviwSgWJMaAAXAOx2Ee7HEr3MUzzIjVWCfpi+Q28sa/ToYTO9uc4YXj4IbSS+Lo0WDF3kqUkiQfbtTRemNiok/COrydqUTvyogGOWlh+dnQlTAqrua1OC85oVCrcxszXvqcfz/9UIbY6TIWGBPtbn66SSZzAAn3gYKzi51XzW7m+30vS0/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Sy3GfYIvO514Ipvg8lZDpuuMElA+cTVbNbIjkGpERY=;
 b=McveNiDSQbI1TIyVH4IpozcPbj5rHF/FxuELLucjDT3C0z1bh/Sw0i6vJaGyd+tcBiFKheGR2h5gvVMZOj6crh/iI8QyY/VzVZ5ziJp/SqHZG5UxgvNeogyO0TAtyhf6eGyrtnZZSEcDg5Do4swdwkCHcG2Nwsw9C2HCgpIwWsrNvnKcchUeulnMh+Csf8rpoUErPlhRBCgoSUqMZZp5RkdWiFl0qCEeiPO5Ky9ZH686wqKCloJqJ2VS7ld0UCX6XVKOQiMvZGyMo4kDyB4EAwYOMbH6squmCGHUfSucEQcfYa8x1awFvAMOp641IBUNlnPc0qpbCBYgYVTdZn1UVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from BY5PR15MB3539.namprd15.prod.outlook.com (2603:10b6:a03:1ff::19)
 by PH3PPF1C905D6E6.namprd15.prod.outlook.com (2603:10b6:518:1::48a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 12:31:18 +0000
Received: from BY5PR15MB3539.namprd15.prod.outlook.com
 ([fe80::5fc4:a5ff:a7c9:8976]) by BY5PR15MB3539.namprd15.prod.outlook.com
 ([fe80::5fc4:a5ff:a7c9:8976%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:31:18 +0000
From: Pranav P <pranav.p7@ibm.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG]: backfill min batch size test case failure on s390x
Thread-Topic: [BUG]: backfill min batch size test case failure on s390x
Thread-Index: AQHbs4FgkKgS/Qv0gESRvGDx8/ewfg==
Date: Tue, 22 Apr 2025 12:31:18 +0000
Message-ID:
 <BY5PR15MB35396BEBCAB2C559080F08C6A0BB2@BY5PR15MB3539.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3539:EE_|PH3PPF1C905D6E6:EE_
x-ms-office365-filtering-correlation-id: 39dabe7d-ff10-4496-d733-08dd81999504
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?d3rNgH7133Jml2lohI3g+CN8ryK315+oUqhfAXx+nRSKZPCsJ3H1vNifrq?=
 =?iso-8859-1?Q?AFAAl+XRy7gMhmJLGTIeNaMjMswiC3fEZvwmbPTQ6Zp9CYoAA3v0I2hZi3?=
 =?iso-8859-1?Q?EhEHxy9CR350sXFVXQorYIVE4fChGZiEDUfgq2JUw8s9xSu6gCicql7h3l?=
 =?iso-8859-1?Q?lnmgVY7MuQ/1wJp+D8oTbYeny81x4lBHDBA7V3nnkohKKb4EK5F/N9VEyW?=
 =?iso-8859-1?Q?xImbKgfl02Xw0hzy59KzUDTclOkOx8RbY+n1xKmHVwB+g2ZPoujnd8cH9+?=
 =?iso-8859-1?Q?zZtLo+1U0me4AiG4CeAETrIGvwoJcIJCKEBEqgre2L8eJaBWHlAi5jcfWD?=
 =?iso-8859-1?Q?MWHf/WBxLa71zagsL4leAd9W4y9tUqFHYUC963AkycqVhAKkkWnLz7iV2g?=
 =?iso-8859-1?Q?RNbjpFNz9TnmbsgDZRDLe6+puNPWPiBnssEJLiG1MQL3yWXOD+ARNaLHFE?=
 =?iso-8859-1?Q?BbuY9yGEFBTP0RJatZSTPXXfccBxtr4C0gUKFpQeZYSvb5p1Mw+7Zf14ku?=
 =?iso-8859-1?Q?D0mYkU3rGrlGMEeSTokJDXJ0yTlXwPnR+U46zi6xxYx/FFQYp/c2zVCKUI?=
 =?iso-8859-1?Q?Cq7sARsxBUC1+VfL9vUEOHd5oVERXKVmOLW0Orplc5d96xipK+Y/nzFCXm?=
 =?iso-8859-1?Q?sAxUc1sND/As52ou438rFHwZFlSf04+bIaCoyc1iBgfgBO7JUL37VsfRgP?=
 =?iso-8859-1?Q?lFTocW5sQqq1ef7hrXAuro7TL2ke2omNa8djBpAGYIJmlg/mbSYxgbe6Bf?=
 =?iso-8859-1?Q?Wx8KuUREJVfi7VoWu6rZOYYIrtEPiNpFeVaUSi94tAJnoHK90qIroOAs+I?=
 =?iso-8859-1?Q?mxsf9a8KnoQP8HUzB4RGgWydVkm7pRcgqeYzUDcGD4ktBe8Ymmv8X6u5I1?=
 =?iso-8859-1?Q?7Nc03//CBCIx00oA+Vax3AlZTHp5Ou55oX7F+xgsLLIAIrTF3CyFF6b01k?=
 =?iso-8859-1?Q?lXqKw3hRNjbm+n0VyBED9OylqIGL4bSKF1z2sHyOg5EmDCWYz4FxZpv/ga?=
 =?iso-8859-1?Q?QS2uzgSYNUixJGLDOe+A15RmNWsEoKE3KQbt2z+sp3oHaXoS0wUkE70wIG?=
 =?iso-8859-1?Q?CxJETaDRRQu9dTfsujxX7fM46srkYdKgPigqdHvlAJUmi2MkM51wX0qHIQ?=
 =?iso-8859-1?Q?rsdgf1qtO7huiuwLE8qalrxn/zCvGYi3XdxBm7zd+Vr8ee0lSNDvdy5te4?=
 =?iso-8859-1?Q?FITA9n7ArNG4NQ/MP3YNn+z2De8jyxdT2STrrlTO+Un1cAga0HWKS5PJd1?=
 =?iso-8859-1?Q?Zpgu8VO/jvy0XkAo/LgHM9D8SlqgnOG2aqB/UFXTtFa1CdiNrfXy/QsVnr?=
 =?iso-8859-1?Q?SiAYpVmtRo2GdQMLpf/TTIAYVEPUgRQ29MFq1/kQ/OW23RbVl4NT2B/g/2?=
 =?iso-8859-1?Q?P38giUboBy5YkbFlFC1iU5e9sCiEgVw09QC9goalq1fSH3OUxd60KzwhDo?=
 =?iso-8859-1?Q?tLosom4IBV9Fw5X0yt3V6K8irPAW7YDtARmN1e40dDAE8pqVAoxjK2EsWk?=
 =?iso-8859-1?Q?LBS9oBvhNnbVDuD3AwDLBOrmp01SBmOLpk8psjWDnwL3PHk7tDAOczTbOr?=
 =?iso-8859-1?Q?Kh/cuFc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3539.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3TQfa3fdiVeROJi+Y4YZKPmT6WnYtTHS/AwW/y22fXNkNFFkEVKvHMG8H+?=
 =?iso-8859-1?Q?2m7ZCmJVczRuG1BkntFUKQwf54p1ggZ/8DcyosBY+v1F6zD7jrJDxi9UUf?=
 =?iso-8859-1?Q?5ifF+N75zSwo7XpcZKtjLAsj53XrVTusWu50+FWdCR9Rv+dxfey/UMMIPG?=
 =?iso-8859-1?Q?BfIuKNzY8ZQxcY6d0RXyJVMNhJsMRlXvSdVi7Oa99/Gy/+lg+D2tD7I8gJ?=
 =?iso-8859-1?Q?chz+bmhVyHOIji33A9m/zIZvsehnb0XbMMHgZmigUSMVEqdN6ecGyBEInd?=
 =?iso-8859-1?Q?FYpsYog3JVLhMdMaalzQS/IsVBbs7HRX1VZRWvsiOJh+lD6U+46BtAXEKf?=
 =?iso-8859-1?Q?N+hkxlkSWRSqXwFkb7WBOb2crX2DoiQ+OoL+9nsoxIKnxTYPCPCM4Rcukz?=
 =?iso-8859-1?Q?i/Ujb601+FJr4Z61bAYESx4jpCZdcCO4jqcxRb1j5mwJvSncLcRbxkSvIi?=
 =?iso-8859-1?Q?2YKtdeYFnYmt9UlCWATiVex92FEzNVwzgXg1EdulMi1TFaduOh/gRA97uW?=
 =?iso-8859-1?Q?hwAClhIWqQj6RKdPFzFd5orcKbDYjwVbh4iDPx3Uffa5F2k39bHivQc70e?=
 =?iso-8859-1?Q?pphe2k87huG8iYXIMW/hk0sng4WX3ESDa2Am6Glp6hKU3ksbARfsATix9/?=
 =?iso-8859-1?Q?5YOENrMJcviUd4kG+mGsUntJmtSt4sUBn9s12PW4mymbk6ZdgkCUukSrRc?=
 =?iso-8859-1?Q?THtaezm0RTqIwJGcMTvnqvxOmWeLvxG7XU9HUdYrbwfRkSCtsJccrD0Eo7?=
 =?iso-8859-1?Q?HbC2NT2tavUoI2OBOAnVLG28oNxybQaiYdwr/KMuohXAi90b6D2766Icm9?=
 =?iso-8859-1?Q?FwIaFt6Kf0OcTppJmOINpDZlXau6biZ+XeBWoybmL5XR4rgrT5yz6KSGNc?=
 =?iso-8859-1?Q?NUEP7M4W09As88ceXY+ziD4ZLGZrkVQ+3EyCR2pQ8N/duVeYPyRfjuqYmg?=
 =?iso-8859-1?Q?7D9hF8ucwmA1rjZgLza/X/FLf/Nk2Tlx1rbMQ1MLp8AWKp5sKZ97pFYWD6?=
 =?iso-8859-1?Q?VVbk3Ny/fdf+NG+GY+p3zAeY8tIm+UApVK/0HcaSV1f25p7GfsoBUVZhHI?=
 =?iso-8859-1?Q?xkT3LW7J2H0cDxEicvwM6Tvz5amXXGmY3ocPAn7JKerDxKNkMuDR648FzJ?=
 =?iso-8859-1?Q?8USzWgRgP3ZvVBhYu0jSf+DydbDqgmwdrkCGi2EkvRCW1XttWnEwfTcMiJ?=
 =?iso-8859-1?Q?QHNXUgrV7sDrP03UFryVQhakJaKzKDXIhFG4bvSV5fFQz3ERPoIGetYEg+?=
 =?iso-8859-1?Q?m3muL7LfCvv3B8oVNzN8OGBapKSmssINMBMMn2hLQgGWo/XntwA/aA0OW3?=
 =?iso-8859-1?Q?sK5oHwXHol4hqKLogBha0mfn6QySQ1LrOxqEg6a2IWitWGAV3y4SweSECp?=
 =?iso-8859-1?Q?7c0VBgujvoQCSpug8B1cJ5QjUPoDck2UrEtSjIhkoaA0ncjIyHW3JNDqT4?=
 =?iso-8859-1?Q?i0QQDPvce5IH9Gezcx5KTBPrKx5sYGlFK24HEV/gtVt5d4lT0ZQErBpAqK?=
 =?iso-8859-1?Q?CQS6KUSbvVw//2vAfWwFA0I841ljhhoIpS57Mpz0Vkh+7uP91VCO2ycFdA?=
 =?iso-8859-1?Q?FLhEA8us4xdrcoo2Br/DOnx4WEYc/8Qt6SIgUpeEPNQ8/++ArggvIXAeNI?=
 =?iso-8859-1?Q?P8Vq0r3209y88=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3539.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dabe7d-ff10-4496-d733-08dd81999504
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 12:31:18.6541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUrntls3/thAjzzVi+FIb1wSwlfQHNbwHaV1gRLrJU7CMoePakS5mB5//TMenoUvE3kJTq41NLNVq57FtnB8fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1C905D6E6
X-Proofpoint-GUID: enmmUa1mbs99LDqmPgcF030qGq0fwjvk
X-Proofpoint-ORIG-GUID: enmmUa1mbs99LDqmPgcF030qGq0fwjvk
X-Authority-Analysis: v=2.4 cv=eKcTjGp1 c=1 sm=1 tr=0 ts=68078c19 cx=c_pps a=AVVanhwSUc+LQPSikfBlbg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=xNf9USuDAAAA:8 a=QpfZq4fnGLdjdseNTQcA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220095

Hi,                                                                        =
                                                                           =
                                         =0A=
                                                                           =
                                                                           =
                                         =0A=
When running `make test` on an s390x machine in Debian it is failing on 'do=
 partial clone 2, backfill min batch size'                                 =
                                         =0A=
Reference: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1102106     =
                                                                           =
                                           =0A=
                                                                           =
                                                                           =
                                         =0A=
After processing the command line arguments structure member min_batch_size=
 should have had the value 20                                              =
                                         =0A=
                                                                           =
                                                                           =
                                         =0A=
Instead of having the value 20 (--min-batch-size=3D20) it was having a very=
 large value                                                               =
                                           =0A=
                                                                           =
                                                                           =
                                         =0A=
min_batch_size in `struct backfill_context` is of type `size_t` and since i=
n the function cmd_backfill, in the                                        =
                                         =0A=
options struct it is passed on to OPT_INTEGER, which eventually causes     =
                                                                           =
                                         =0A=
                                                                           =
                                                                           =
                                         =0A=
```                                                                        =
                                                                           =
                                         =0A=
*(int *)opt->value =3D strtol(arg, (char **)&s, 10);                       =
                                                                           =
                                           =0A=
```                                                                        =
                                                                           =
                                         =0A=
in parse-options.c line 188. This is writing the data in the first 4 bytes =
of min_batch_size and on big endian                                        =
                                         =0A=
systems this will lead min_batch_size to be a big number. This issue is imm=
ediately visible in little endian systems.                                 =
                                         =0A=
                                                                           =
                                                                           =
                                         =0A=
Changing OPT_INTEGER to OPT_MAGNITUDE seems to be working on x86 and s390x =
                                                                           =
                                         =0A=
                                                                           =
                                                                           =
                                         =0A=
```                                                                        =
                                                                           =
                                         =0A=
diff --git a/builtin/backfill.c b/builtin/backfill.c                       =
                                                                           =
                                         =0A=
index 18f9701487..33e1ea2f84 100644                                        =
                                                                           =
                                         =0A=
--- a/builtin/backfill.c                                                   =
                                                                           =
                                         =0A=
+++ b/builtin/backfill.c                                                   =
                                                                           =
                                         =0A=
@@ -123,7 +123,7 @@ int cmd_backfill(int argc, const char **argv, const cha=
r *prefix, struct reposit                                                  =
                                         =0A=
                .sparse =3D 0,                                             =
                                                                           =
                                           =0A=
        };                                                                 =
                                                                           =
                                         =0A=
        struct option options[] =3D {                                      =
                                                                           =
                                           =0A=
-               OPT_MAGNITUDE(0, "min-batch-size", &ctx.min_batch_size,    =
                                                                           =
                                         =0A=
+               OPT_INTEGER(0, "min-batch-size", &ctx.min_batch_size,      =
                                                                           =
                                         =0A=
                            N_("Minimum number of objects to request at a t=
ime")),                                                                    =
                                         =0A=
                OPT_BOOL(0, "sparse", &ctx.sparse,                         =
                                                                           =
                                         =0A=
                         N_("Restrict the missing objects to the current sp=
arse-checkout")),                                                          =
                                         =0A=
```                                                                        =
                                                                           =
                                         =0A=
                                                                           =
                                                                           =
                                         =0A=
But on systems where size_t which not be unsigned long, this might lead to =
an issue.                                                                  =
                                         =0A=
So, one other suggestion I have is to change the data type of min_batch_siz=
e from size_t to int. But I am not able to                                 =
                                         =0A=
determine whether a practical upper bound for min_batch_size would exceed w=
hat an int variable can store.                                             =
                                         =0A=
With that clarification, I can a raise patch for the issue.                =
                                                                           =
                                         =0A=
                                                                           =
                                                                           =
                                         =0A=
Please review the rest of the bug report below.=0A=
=0A=
[System Info]                                                              =
                                                                           =
                                         =0A=
git version:                                                               =
                                                                           =
                                         =0A=
git version 2.49.0.391.g4bbb303af6                                         =
                                                                           =
                                         =0A=
cpu: s390x                                                                 =
                                                                           =
                                         =0A=
built from commit: 4bbb303af69990ccd05fe3a2eb58a1ce036f8220                =
                                                                           =
                                         =0A=
sizeof-long: 8                                                             =
                                                                           =
                                         =0A=
sizeof-size_t: 8                                                           =
                                                                           =
                                         =0A=
shell-path: /bin/sh                                                        =
                                                                           =
                                         =0A=
libcurl: 8.13.0                                                            =
                                                                           =
                                         =0A=
OpenSSL: OpenSSL 3.4.1 11 Feb 2025                                         =
                                                                           =
                                         =0A=
zlib: 1.3.1                                                                =
                                                                           =
                                         =0A=
SHA-1: SHA1_DC                                                             =
                                                                           =
                                         =0A=
SHA-256: SHA256_BLK                                                        =
                                                                           =
                                         =0A=
uname: Linux 6.1.0-31-s390x #1 SMP Debian 6.1.128-1 (2025-02-07) s390x     =
                                                                           =
                                         =0A=
compiler info: gnuc: 14.2                                                  =
                                                                           =
                                         =0A=
libc info: glibc: 2.41                                                     =
                                                                           =
                                         =0A=
$SHELL (typically, interactive shell): /bin/bash                           =
                                                                           =
                                         =0A=
                                                                           =
                                                                           =
                                         =0A=
                                                                           =
                                                                           =
                                         =0A=
[Enabled Hooks]=0A=
=0A=
I am fairly new to opensource and was following the `git bugreport`. So I a=
m extremely sorry for any lack of clarity in the report.=0A=
=0A=
Thanks,=0A=
Pranav=
